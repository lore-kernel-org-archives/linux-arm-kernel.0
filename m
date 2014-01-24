From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Jan 2014 23:09:31 +0800
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <20140119185246.GB28056@quad.lixom.net>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
 <20140119031816.GD16158@S2101-09.ap.freescale.net>
 <20140119185246.GB28056@quad.lixom.net>
Message-ID: <20140124150927.GA2780@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 10:52:46AM -0800, Olof Johansson wrote:
> I'm well aware that the DT branch has not been merged, and that's because
> there has been no consensus from DT maintainers on the massive rework
> you did as the base of the branch.

I guess the 'massive rework' you're talking about is the patch series
that begins with 'ARM: dts: imx6qdl: make pinctrl nodes board specific'?
If so, I hope you would agree that we're trying to solve a real
problem [1], even though the solution does not look like the best to
you.

So which specific part of the solution are you objecting to?  Those
MX6QDL_*_PINGRP macros defined in imx6qdl-pingrp.h?  If that's the
case, I can send a follow-up patch to kill the macros by filling in the
pin group definitions directly.  The pros is that the pin group
definitions for given board will be more intuitive, and the cons is that
the change set will be even more massive, because the same multi-lines
pin group definitions will be duplicated in multiple board dts files,
which use the same group of pins for given device.

Or any other better idea?

> 
> Given the timing, it's not looking like it will be resolved in time for
> the 3.14 merge window (which might open today).

That's frustrating and will be surprising a lot of people who expect to
see their board support in 3.14 release.

Shawn


[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/
