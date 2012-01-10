From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 23:41:12 +0800
Subject: [PATCH v2] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <1326191059-26411-1-git-send-email-thierry.reding@avionic-design.de>
References: <1326191059-26411-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120110154109.GB27831@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 11:24:11AM +0100, Thierry Reding wrote:
> The irq_domain_add() function needs the number of interrupts in the
> domain to properly initialize them. In addition the allocated domain
> is now returned by the irq_domain_{add,generate}_simple() helpers.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: David Brown <davidb@codeaurora.org>
> ---
> Note: This patch should not be applied yet. There is a conflict with a
>       pending patch[0] by Benoit Cousson that will obsolete the OMAP2
>       hunk in this patch.
> 
>       [0]: http://www.spinics.net/lists/linux-omap/msg62124.html
> 
> Changes in v2:
>  - Don't use ERR_PTR, keep the WARN_ON(1) and return NULL as requested
>    by Grant Likely.
>  - Integrate i.MX cleanup patch by Shawn Guo.
> 
...
>  arch/arm/mach-imx/imx51-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/imx53-dt.c          |   13 +++++++++++--
>  arch/arm/mach-imx/mach-imx6q.c        |    6 +++++-
...
>  arch/arm/plat-mxc/include/mach/irqs.h |   13 +++++++------
>  arch/arm/plat-mxc/tzic.c              |    2 --

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn
