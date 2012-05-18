From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Fri, 18 May 2012 16:02:09 +0200
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
Message-ID: <4091807.RyPhQZZ7JC@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 18 mai 2012 00:48:35 Fabio Estevam a ?crit :
> Hi Sascha,
> 
> Are you able to boot any mx31 system on linux-next-20120517?

I'm not able to boot it, it does hang/crash in the device initcall:
(...)
[    0.274656] initlevel:6=device, 135 registered initcalls
[    0.286256] msgmni has been set to 227
[    0.289522] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 
252)
[    0.289548] io scheduler noop registered
[    0.289570] io scheduler cfq registered (default)
[    0.413953] mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
[    0.544110] Console: switching to colour frame buffer device 60x40
[    0.555321] imx-sdma imx31-sdma: loaded firmware 1.0
[    0.588970] imx-sdma imx31-sdma: initialized
[    0.590912] Serial: IMX driver
[    0.591139] imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
[    1.260201] console [ttymxc0] enabled
[    1.278640] spi_imx imx31-cspi.1: master is unqueued, this is deprecated

But I don't need to enable earlyprintk to get serial output.
BTW, this is not limited to mx31pdk_3ds, but it also do it on mx31moboard.

It looks like it's related to the mc13783 PMIC, because the board *poweroff* 
itself. 

Maybe it's a bug in the regmap work of the mc13783 ?

Regards,

Philippe
