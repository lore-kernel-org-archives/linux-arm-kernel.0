From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 16:21:31 -0800
Subject: [PATCH 2/2] arm: mach-omap2: Kconfig: devkit8000 should select
	needed options
In-Reply-To: <alpine.DEB.1.10.1012171424030.13087@esdhcp041196.research.nokia.com>
References: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com>
	<1292417352-18082-2-git-send-email-aaro.koskinen@nokia.com>
	<20101215173709.GB8406@atomide.com>
	<alpine.DEB.1.10.1012171424030.13087@esdhcp041196.research.nokia.com>
Message-ID: <20101218002131.GZ5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [101217 04:41]:
> Hi,
> 
> On Wed, 15 Dec 2010, Tony Lindgren wrote:
> >* Aaro Koskinen <aaro.koskinen@nokia.com> [101215 04:48]:
> >>It's not possible to compile a kernel for this board without I2C,
> >>MFD_SUPPORT and TWL4030_CORE, so those should be selected. This will
> >>prevent build errors when trying out different configurations.
> >
> >This one I'm not so convinced about. We should be able to compile
> >support for each board and enable and disable these kind of options
> >just fine if CONFIG_ARCH_OMAP2PLUS_TYPICAL is disabled.
> 
> So in this case we should move the stuff with special dependencies from
> the board file into e.g. board-devkit8000-peripherals, which would be
> a kernel module?

Or how about just have them in ifdef CONFIG_I2C_OMAP and TWL4030_CORE
in the board-devkit8000.c file?

Regards,

Tony
