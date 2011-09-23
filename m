From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Sep 2011 16:29:02 +0200
Subject: [PATCH] ARM i.MX avic: convert to use generic irq chip
In-Reply-To: <4E7C49AE.8070101@gmail.com>
References: <1316684408-12196-1-git-send-email-jason77.wang@gmail.com>
	<20110922135009.GA15024@S2100-06.ap.freescale.net>
	<4E7C49AE.8070101@gmail.com>
Message-ID: <20110923142902.GM31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 04:56:14PM +0800, Hui Wang wrote:
> Shawn Guo wrote:
> >On Thu, Sep 22, 2011 at 05:40:08PM +0800, Hui Wang wrote:
> >>Convert i.MX avic irq handler to use generic irq chip. This not only
> >>provides a cleanup implementation of irq chip handler, but also
> >>implements suspend/resume interface with the help of generic irq chip
> >>interface.
> >>
> >>Change mxc_irq_chip to a new structure mxc_extra_irq to handle fiq
> >>and priority functions.
> >>
> >>Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> >>---
> >>
> >>This patch is basing on imx-features branch of linux-pengu. Have
> >>validated this patch on 31pdk and 35pdk platforms, while have no
> >>chance to validate it on mx2 and mx1 platforms since we don't have
> >>those hardwares.
> >>
> >>The purpose of changing avic to use generic irq chip is because i
> >>added suspend/resume functions for 35pdk, and generic irq chip
> >>naturally has suspend/resume interface. If this patch can be
> >>accepted, i will continue to send out those 35pdk pm patches.
> >>
> >> arch/arm/plat-mxc/avic.c       |   79 ++++++++++++++++++++++++++++------------
> >> arch/arm/plat-mxc/irq-common.c |   21 ++++++-----
> >> arch/arm/plat-mxc/irq-common.h |    3 +-
> >> arch/arm/plat-mxc/tzic.c       |    8 ++++-
> >> 4 files changed, 75 insertions(+), 36 deletions(-)
> >>
> >Acked-by: Shawn Guo <shawn.guo@linaro.org>
> >
> >However, I'm wondering if you can add the suspend/resume interface for
> >tzic as well.
> Yes, this is the next plan, if this patch can be accepted, i will
> add tzic suspend/resume as well.

It is, go ahead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
