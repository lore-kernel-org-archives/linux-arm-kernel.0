From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 28 May 2013 21:01:49 +0800
Subject: [PATCH] ARM: dt: Use the 'model' field for printing the hardware
 revision
In-Reply-To: <CAOMZO5D6dM6+a7mgRy8KgPrSxu0GYXw8VvzqVVQTAVRt+TVb-g@mail.gmail.com>
References: <1369742670-16305-1-git-send-email-fabio.estevam@freescale.com>
 <20130528121506.GL11166@pengutronix.de>
 <CAOMZO5D6dM6+a7mgRy8KgPrSxu0GYXw8VvzqVVQTAVRt+TVb-g@mail.gmail.com>
Message-ID: <AC44A003-DDC4-4EB6-A67B-97F69426764F@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 28, 2013, at 8:57 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Uwe,
> 
> On Tue, May 28, 2013 at 9:15 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
>>> struct machine_desc {
>>>      unsigned int            nr;             /* architecture number  */
>>>      const char              *name;          /* architecture name    */
>>> +     const char              *model;         /* architectute model */
>> s/architectute/architecture/
> 
> Thanks for reviewing it. Will fix in v2.
> 
>> 
>> Is it really needed to add a new field here? Alternatively overwrite
>> name or do something like:
>> 
>>        if (this_is_a_device_tree_machine)
>>                seq_printf(m, "Hardware\t: %s\n", get_model_from_dt());
>>        else
>>                seq_printf(m, "Hardware\t: %s\n", machine_name);

> I was not able to find a good trick that provides me the
> 'this_is_a_device_tree_machine' information inside the c_show()
> function, so I ended up adding a the model inside machine_desc struct.
> 

if the dt is present means this is a dt machine
or the machine_id

Best Regards,
J.

> Regards,
> 
> Fabio Estevam
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
