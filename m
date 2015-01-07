From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Jan 2015 22:00:29 -0500
Subject: [PATCH v2] irqchip: omap-intc: fix legacy DMA regression
In-Reply-To: <1420576688-10604-1-git-send-email-balbi@ti.com>
References: <1420563093-26026-1-git-send-email-balbi@ti.com>
 <1420576688-10604-1-git-send-email-balbi@ti.com>
Message-ID: <20150107030029.GE24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 02:38:08PM -0600, Felipe Balbi wrote:
> commit 55601c9f2467 (arm: omap: intc: switch over
> to linear irq domain) introduced a regression with
> SDMA legacy driver because that driver strictly depends
> on INTC's IRQs starting at NR_IRQs. Aparently
> irq_domain_add_linear() won't guarantee that, since we see
> a 7 IRQs difference when booting with and without the
> commit cited above.
> 
> Until arch/arm/plat-omap/dma.c is properly fixed, we
> must maintain OMAP2/3 using irq_domain_add_legacy().
> 
> A FIXME note was added so people know to delete that
> code once that legacy DMA driver is fixed up.
> 
> Fixes: 55601c9f2467 (arm: omap: intc: switch over to linear irq domain)
> Cc: <stable@vger.kernel.org> # v3.18
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/irqchip/irq-omap-intc.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Applied to irqchip/urgent.  Thanks for taking care of the Fixes and
stable tags!

thx,

Jason.
