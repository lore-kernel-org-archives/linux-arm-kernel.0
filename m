From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Jul 2010 10:34:44 +0200
Subject: ARM Kernel autobuilder
In-Reply-To: <20100722111412.GB10399@kyllikki.org>
References: <20100722111412.GB10399@kyllikki.org>
Message-ID: <20100723083444.GA6690@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vincent,

On Thu, Jul 22, 2010 at 12:14:12PM +0100, Vincent Sanders wrote:
> The ns9xxx configuration has been failing for even longer and teh
> machines supported are maintainerd by Uwe Kleine-Konig
See patch that I just sent to this thread.  Russell: is it already to
late for .36?  Should I send my patch to your patch system?
There is also still a Kconfig-Warning in some imx-builds.

Vincent: one thing I noticed a while back is that kautobuild doesn't
report the section mismatch warnings.  See for example

	http://armlinux.simtec.co.uk/kautobuild/2.6.35-rc6/cam60_defconfig/zimage.log

It has:

	...
	  LD      vmlinux.o
	  MODPOST vmlinux.o
	WARNING: modpost: Found 1 section mismatch(es).
	To see full details build your kernel with:
	'make CONFIG_DEBUG_SECTION_MISMATCH=y'

Still

	http://armlinux.simtec.co.uk/kautobuild/2.6.35-rc6/cam60_defconfig.html

claims to have found no warnings.

Can you please consider adding CONFIG_DEBUG_SECTION_MISMATCH=y to your
build and extend the warning regexp?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
