From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 May 2013 09:57:20 -0300
Subject: [PATCH] ARM: dt: Use the 'model' field for printing the hardware
 revision
In-Reply-To: <20130528121506.GL11166@pengutronix.de>
References: <1369742670-16305-1-git-send-email-fabio.estevam@freescale.com>
 <20130528121506.GL11166@pengutronix.de>
Message-ID: <CAOMZO5D6dM6+a7mgRy8KgPrSxu0GYXw8VvzqVVQTAVRt+TVb-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, May 28, 2013 at 9:15 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>>  struct machine_desc {
>>       unsigned int            nr;             /* architecture number  */
>>       const char              *name;          /* architecture name    */
>> +     const char              *model;         /* architectute model */
> s/architectute/architecture/

Thanks for reviewing it. Will fix in v2.

>
> Is it really needed to add a new field here? Alternatively overwrite
> name or do something like:
>
>         if (this_is_a_device_tree_machine)
>                 seq_printf(m, "Hardware\t: %s\n", get_model_from_dt());
>         else
>                 seq_printf(m, "Hardware\t: %s\n", machine_name);

I was not able to find a good trick that provides me the
'this_is_a_device_tree_machine' information inside the c_show()
function, so I ended up adding a the model inside machine_desc struct.

Regards,

Fabio Estevam
