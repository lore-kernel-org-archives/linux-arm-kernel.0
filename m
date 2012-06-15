From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 17:30:56 +0800
Subject: [PATCH 06/16] ARM: imx: move irq_domain_add_legacy call into
 avic driver
In-Reply-To: <20120614071326.GC31565@S2101-09.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-7-git-send-email-shawn.guo@linaro.org>
 <20120614071326.GC31565@S2101-09.ap.freescale.net>
Message-ID: <20120615093055.GD8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:13:28PM +0800, Shawn Guo wrote:
> On Thu, Jun 14, 2012 at 01:59:37PM +0800, Shawn Guo wrote:
> > Move irq_domain_add_legacy call from imx27-dt.c into avic init function
> > and have the avic driver adopt irqdomain support for both DT and non-DT
> > boot.
> > 
> > Now avic init function calls irq_alloc_descs to get irq_base and adds
> > a lenacy irqdomain with the irq_base, so that the mapping between avic
> > irq and Linux irq number can be handled by irqdomain.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/imx27-dt.c |   15 ---------------
> >  arch/arm/plat-mxc/avic.c     |   26 +++++++++++++++++++-------
> >  2 files changed, 19 insertions(+), 22 deletions(-)
> > 
> The following changes should be amended.
> 

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
