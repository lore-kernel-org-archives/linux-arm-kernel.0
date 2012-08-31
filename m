From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 Aug 2012 11:53:37 +0200
Subject: [PATCH 1/2] i2c-omap: Fix incorrect adapter id when booting from
 a device tree
In-Reply-To: <5040806C.9080003@ti.com>
References: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch>
 <1346399575-7285-2-git-send-email-florian.vaussard@epfl.ch>
 <5040806C.9080003@ti.com>
Message-ID: <504089A1.3030000@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

> [    0.658843] omap_i2c i2c.15: bus -1 rev2.4.0 at 400 kHz
> [    0.760192] omap_i2c i2c.16: bus -1 rev2.4.0 at 400 kHz
> [    0.775817] omap_i2c i2c.17: bus -1 rev2.4.0 at 400 kHz
> [    0.791442] omap_i2c i2c.18: bus -1 rev2.4.0 at 400 kHz
>
> OK, it is true that the current log is not that nice with bus -1, but
> maybe we should just remove that.
>
> Or we can potentially retrieve the i2c adapter number assign later, and
> delay the log.
>
>>   	r = i2c_add_numbered_adapter(adap);
>>   	if (r) {
>>   		dev_err(dev->dev, "failure adding adapter\n");
I agree, we should defer the log if we want a nice print. I will send a 
new patch.

Regards,
Florian
