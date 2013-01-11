From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 10:25:27 +0800
Subject: [PATCH 1/4] ARM: dts: mxs-phy: Change mxs phy clock usage
In-Reply-To: <1357806954-27960-1-git-send-email-peter.chen@freescale.com>
References: <1357806954-27960-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130111022525.GC9139@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:35:51PM +0800, Peter Chen wrote:
> For mxs-phy user i.mx6q, the PHY's clock is controlled by
> hardware automatically, the software only needs to enable it
> at probe, this clock should be used like below:
> 
> - Enable at mxs-phy's probe, and disable at mxs-phy's remove, so
> The clk framework doesn't need to know it. But other mxs-phy user
> mx28/mx23 may need it, so we give mxs-phy a dummy clock for imx6q.
> - During the runtime, we don't need to control it.
> 
Turning it into a dummy clock, you will have no way to maintain the
use count.  It could possibly cause parent clock be turned off while
usbphy is in use.

Let's try to find some other way.

Shawn
