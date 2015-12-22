From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 16:16:42 +0000
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <CAOMZO5CXqNNv7hv0kwyqQiQvo4d_X1jN8jf4QPmEJQvMogHzGA@mail.gmail.com>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
 <20151222125300.GH8644@n2100.arm.linux.org.uk>
 <20151222150259.GL8644@n2100.arm.linux.org.uk>
 <CAOMZO5CXqNNv7hv0kwyqQiQvo4d_X1jN8jf4QPmEJQvMogHzGA@mail.gmail.com>
Message-ID: <20151222161642.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon is busy at the moment, and I expect will reply in a few hours or
so.

On Tue, Dec 22, 2015 at 01:31:53PM -0200, Fabio Estevam wrote:
> It seems the information you got from Jon is not correct.

I suspect Jon is in a better position to comment about what works and
what doesn't, as he's doing the customer facing support for SolidRun,
and has to deal with people trying to run stock u-boot on SolidRun's
hardware.

_Especially_ when he gets regular reports from users trying to run
Fedora 23 on SolidRun platforms, which ships with mainline u-boot,
and it fails to work because mainline u-boot gets stuff wrong.  The
telling thing for Jon is that when he gets users to switch to SR's
u-boot, the problems magically vanish.

> We do support several versions of Hummingboard and Cubox-i (at least
> for the board models I have access to) in mainline U-boot.

Maybe, rather than this "vendors are evil, we must write our own patches
which are independent of the vendor" attitude, maybe people ought to
work _with_ vendors?  Jon is an open source guy, he was working on OLPC
before he switched to the SolidRun platforms, first as a hobby and later
as their kernel and uboot maintainer.  He's not an evil vendor!

> The SDRAM is correctly setup depending on the board type:
> http://git.denx.de/?p=u-boot.git;a=history;f=board/solidrun/mx6cuboxi/mx6cuboxi.c;h=fc37f1eef06da5147e5403d4272d220836c9cfbc;hb=HEAD
> 
> Like you said in the past only the old mx6d hummingboard was
> supported, but we are in better shape now and the old support has been
> removed.

Jon is aware of what's in mainline u-boot, and the memory timings there
are wrong.  For a start, the highest DDR clock rate is 1066MHz, not
1600MHz that you have in mainline u-boot.  So you're overclocking the
SDRAM.

I know that Jon has put a _lot_ of effort into getting the SDRAM setup
stable on SolidRun hardware to eliminate hangs and other problems, and
it seems the attitude is "we don't care about that, we're mainline, we
know better."

So, excuse me if I trust Jon's comments about uboot more than anyone
elses.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
