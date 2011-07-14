From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 14 Jul 2011 12:23:43 -0500
Subject: [RFC 0/6] watchdog drivers converted to the new framework
In-Reply-To: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383E05B65@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2011 1:26 PM, Wolfram Sang wrote:
> As promised, here is a RFC with two examples demonstrating how watchdog drivers
> can be converted to use the new watchdog framework (using the current version
> Wim posted two days ago). There is also conversion guide put to the
> documentation folder. Being RFC, all this is not final yet, but presentable, I
> hope.
> 
> Although there are a few more consolidation options left, there is already a
> gain of ~100 lines per driver. Promising, but there are a few issues to be
> sorted out, too, yet nothing which can be dealt with.
> 
> I have two other drivers in the making (stmp3xxx and imx2), but they need some
> more preparation; the first one needs some internal cleanups (like a lot of
> watchdog drivers); the latter one needs an addition to the framework
> (installing a timer for non-stoppable devices). I will also prepare a new
> driver (mx1) to show how small new drivers can be now :) The aim for all these
> driver conversions is inclusion in Linux 3.2. I still hope we can get the basic
> framework into Linux 3.1.
> 
> Many thanks to CELF/LF for supporting this work and to Wim and Alan for making
> the framework!
> 
> Looking forward to comments,

What's the status on Wim's watchdog framework patches?  It would be nice to have
them re-posted and CC the linux-arm-kernel list.  Not everyone follows lkml
regularly.

I found Wim's patches on lkml and converted the ep93xx watchdog driver and get:

 drivers/watchdog/ep93xx_wdt.c |  174 +++++++++-------------------------------
 1 files changed, 39 insertions(+), 135 deletions(-)

Overall I like the results.  It also makes the driver a lot easier to follow.

I would also like to convert this driver into a proper platform_driver using
ioremap'ed addresses instead of the static mappings.  Converting the driver
to the new watchdog framework would make this a bit cleaner.

Regards,
Hartley
