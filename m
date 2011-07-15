From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jul 2011 09:56:36 +0200
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
In-Reply-To: <4E1C7EA7.7060800@boundarydevices.com>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110712133231.GQ6069@pengutronix.de>
	<4E1C7EA7.7060800@boundarydevices.com>
Message-ID: <20110715075636.GI26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 10:04:39AM -0700, Troy Kisky wrote:
> On 7/12/2011 6:32 AM, Sascha Hauer wrote:
> > Troy,
> > 
> > On Sat, Jul 09, 2011 at 03:51:53PM -0700, Troy Kisky wrote:
> >> The i.MX51 UART_PADDR value does not work for MX50/53.
> >>
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > 
> > Please rebase the patch on my for-next branch and use CONFIG_SOC_IMX*
> > instead of CONFIG_ARCH_*.
> > 
> > Sascha
> > 
> >> ---
> 
> From arch/arm/mach-mx5/Kconfig
> 
> # ARCH_MX5/50/53 are left to mark places where prevent multi-soc in single
> # image. So for most time, SOC_IMX50/51/53 should be used.
> 
> 
> So, it would seem to me that the ARCH variant would be correct.

No, we want to get rid of CONFIG_ARCH_MX*. The debug macro stuff is a
bit special as we intentionally disable multi soc kernels for the low
level debug case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
