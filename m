From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Apr 2012 18:16:59 -0300
Subject: gpio irqs broken on imx27 with dt
In-Reply-To: <20120427125048.GN20039@pengutronix.de>
References: <20120427125048.GN20039@pengutronix.de>
Message-ID: <CAOMZO5D5s6sApB6EDUgPDb50gReBpGV8HP8KdMeHomsY0tsrqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

2012/4/27 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> I experience problems on using gpio irqs on an imx27 based machine
> booting with dt.

Currently there is no pinctrl driver for mx27.

What you can do as a temporary workaround is to do the same as mx51 or mx53:

config MACH_IMX51_DT
	bool "Support i.MX51 platforms from device tree"
	select SOC_IMX51
	select MACH_MX51_BABBAGE
	select USE_OF
	help
	  Include support for Freescale i.MX51 based platforms
	  using the device tree for discovery

MACH_IMX51_DT currently selects MACH_MX51_BABBAGE so that the IOMUX
infrastructure can be used.

Regards,

Fabio Estevam
