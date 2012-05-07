From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 7 May 2012 15:53:44 +0800
Subject: [PATCH RESEND 0/5] Adopt pinctrl support for a few outstanding
 imx drivers
In-Reply-To: <20120507073403.GG19389@S2101-09.ap.freescale.net>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
 <20120507065001.GA23607@shlinux2.ap.freescale.net>
 <20120507073403.GG19389@S2101-09.ap.freescale.net>
Message-ID: <20120507075344.GC23607@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 03:34:06PM +0800, Shawn Guo wrote:
> On Mon, May 07, 2012 at 02:50:02PM +0800, Dong Aisheng wrote:
> > Shouldn't we add the pinctrl states in dts file at the same time
> > with this patch series or using another separate patch to add them
> > before this series to avoid breaking the exist mx6q platforms?
> > 
> Ah, I just noticed that your patch "ARM: imx: enable pinctrl dummy
> states" did not cover imx6q.  I think we should do the same for imx6q,
Yes, doing that was to force people to add pinctrl states in dts file
rather than using dummy state since mx6 supports pinctrl driver.

> so that we can separate dts update from the driver change.  When all
> imx6q boards' dts files get updated to have pins defined for the
> devices, we can then remove dummy state for imx6q.  Doing so will ease
> the pinctrl migration for those imx6q boards.
> 
Well, considering we have several mx6 boards, i think i can also be fine
with this way to ease the mx6q pinctrl migration.

> Will update your patch on my branch to have dummy state enabled for
> imx6q.
> 
Then go ahead.

Regards
Dong Aisheng
