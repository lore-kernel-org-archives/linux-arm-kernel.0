From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 20:12:24 +0800
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
In-Reply-To: <20120502114121.GB5722@opensource.wolfsonmicro.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
 <20120501134446.GK2194@S2101-09.ap.freescale.net>
 <20120502105024.GC2982@b20223-02.ap.freescale.net>
 <20120502114121.GB5722@opensource.wolfsonmicro.com>
Message-ID: <20120502121222.GZ2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 12:41:22PM +0100, Mark Brown wrote:
> We generally try to keep the clock API out of CODEC drivers due to the
> issues with the clock API that the generic implementation is intended to
> help us solve.
> 
> The major problem here is that we can't rely on having the clock API
> present at all on most platforms so as soon as we start adding clock
> support into things we have to do a performance with HAVE_CLK which is
> at best annoying.
> 
Is this something that the series below tries to solve?

http://thread.gmane.org/gmane.linux.ports.arm.kernel/163652

Regards,
Shawn

> There's also the fact that even if the clock API is available we've no
> way to register a clock consistently and since the audio clock tree
> often needs management off-SoC for at least some components when the
> clock API is in use you end up having to handle clock trees that go into
> and out of the clock API.
> 
> The upshot of this is that while we really should be using the clock API
> for clocks the API as it stands is somewhat difficult to deploy in cross
> platform code.  What I'd suggest is connecting the clock to the CODEC in
> the device tree but actually doing the clk_get() in the machine driver.
