From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Nov 2011 14:51:01 -0200
Subject: [PATCH v3] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <4EBAA038.6010606@pengutronix.de>
References: <1320401551-21377-1-git-send-email-b39297@freescale.com>
 <4EBAA038.6010606@pengutronix.de>
Message-ID: <CAOMZO5Af9XCB8OGGJo0Hb-Bhhv_R==cS-D3jeC-NKvzbANbMyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 1:46 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> +static int mc9s08dz60_remove(struct i2c_client *client)
>> +{
>> + ? ? struct mc9s08dz60 *mc9s;
>> + ? ? int ret;
>> +
>> + ? ? mc9s = i2c_get_clientdata(client);
>> +
>> + ? ? i2c_set_clientdata(client, NULL);
>> +
>> + ? ? ret = gpiochip_remove(&mc9s->chip);
>> + ? ? if (!ret)
>> + ? ? ? ? ? ? kfree(mc9s);
>> +
>> + ? ? return 0;
>
> return 0 if gpiochip_remove() fails?

See Russell's comment about returning error on this remove function:
http://www.spinics.net/lists/arm-kernel/msg146501.html

Regards,

Fabio Estevam
