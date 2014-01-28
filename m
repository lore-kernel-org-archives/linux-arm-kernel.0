From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 19:20:49 +0800
Subject: [PATCH 2/9] ARM: dts: imx6sl: remove the use of pingrp macros
In-Reply-To: <5923680.sl3G3EgCsY@phil>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <1390668191-20289-3-git-send-email-shawn.guo@linaro.org>
 <5923680.sl3G3EgCsY@phil>
Message-ID: <20140128112047.GC20583@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 11:17:22AM +0100, Heiko St?bner wrote:
> [... and so on for the other groups ... ]
> 
> I'm confused now :-) . Current linux-next [0] shows the pin-settings as part 
> of imx6sl.dtsi - a way a lot of other architectures organize their pingroups 
> too, with the board file only referencing the relevant pingroups from the 
> predefined ones of the soc.
> 
> So I guess your move to the pingrp-header moved them out of the imx6sl.dtsi to 
> the .h and is not part of linux-next;

Yes, my for-next branch was excluded from linux-next temporarily for
some reason.  I will ask Stephen to add it back once v3.14-rc1 is out.
That said, you can see nothing we developed in this cycle on linux-next
for now.

> but this patch (and the others in this 
> series) now moves the definitions into the individual board files. Can't you 
> just move them back to the soc-dtsi files to prevent each board duplicating 
> them?

No.  That will bring back the problem we try to solve from the
beginning [1].

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/275912/
