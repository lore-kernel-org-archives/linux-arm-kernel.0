From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 26 Sep 2010 13:37:37 +0400
Subject: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
	<AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
Message-ID: <20100926093737.GA24005@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Sep 26, 2010 at 05:02:29AM -0400, zhangfei gao wrote:
> On Tue, Sep 21, 2010 at 8:30 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > +++ b/drivers/mmc/host/sdhci-pltfm.h
> > @@ -13,6 +13,11 @@
> >
> > ?#include <linux/sdhci-pltfm.h>
> >
> > +struct sdhci_pltfm_host {
> > + ? ? ? struct clk *clk;
> > + ? ? ? u32 scratchpad; /* to handle quirks across io-accessor calls */
> > +};
> > +
> How about move private data to child driver, and one call back
> function alloc_host, then child driver could alloc private data,
> including clk.

IMHO, this sounds like a bit of overdesign/overcomplication.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
