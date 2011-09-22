From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 Sep 2011 21:50:11 +0800
Subject: [PATCH] ARM i.MX avic: convert to use generic irq chip
In-Reply-To: <1316684408-12196-1-git-send-email-jason77.wang@gmail.com>
References: <1316684408-12196-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20110922135009.GA15024@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 05:40:08PM +0800, Hui Wang wrote:
> Convert i.MX avic irq handler to use generic irq chip. This not only
> provides a cleanup implementation of irq chip handler, but also
> implements suspend/resume interface with the help of generic irq chip
> interface.
> 
> Change mxc_irq_chip to a new structure mxc_extra_irq to handle fiq
> and priority functions.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
> 
> This patch is basing on imx-features branch of linux-pengu. Have
> validated this patch on 31pdk and 35pdk platforms, while have no
> chance to validate it on mx2 and mx1 platforms since we don't have
> those hardwares.
> 
> The purpose of changing avic to use generic irq chip is because i
> added suspend/resume functions for 35pdk, and generic irq chip
> naturally has suspend/resume interface. If this patch can be
> accepted, i will continue to send out those 35pdk pm patches.
> 
>  arch/arm/plat-mxc/avic.c       |   79 ++++++++++++++++++++++++++++------------
>  arch/arm/plat-mxc/irq-common.c |   21 ++++++-----
>  arch/arm/plat-mxc/irq-common.h |    3 +-
>  arch/arm/plat-mxc/tzic.c       |    8 ++++-
>  4 files changed, 75 insertions(+), 36 deletions(-)
> 
Acked-by: Shawn Guo <shawn.guo@linaro.org>

However, I'm wondering if you can add the suspend/resume interface for
tzic as well.

-- 
Regards,
Shawn
