From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 10:34:09 -0800
Subject: [PATCH v2] irqchip: omap-intc: fix legacy DMA regression
In-Reply-To: <20150107030029.GE24989@titan.lakedaemon.net>
References: <1420563093-26026-1-git-send-email-balbi@ti.com>
 <1420576688-10604-1-git-send-email-balbi@ti.com>
 <20150107030029.GE24989@titan.lakedaemon.net>
Message-ID: <20150119183409.GZ18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Cooper <jason@lakedaemon.net> [150106 19:03]:
> On Tue, Jan 06, 2015 at 02:38:08PM -0600, Felipe Balbi wrote:
> > commit 55601c9f2467 (arm: omap: intc: switch over
> > to linear irq domain) introduced a regression with
> > SDMA legacy driver because that driver strictly depends
> > on INTC's IRQs starting at NR_IRQs. Aparently
> > irq_domain_add_linear() won't guarantee that, since we see
> > a 7 IRQs difference when booting with and without the
> > commit cited above.
> > 
> > Until arch/arm/plat-omap/dma.c is properly fixed, we
> > must maintain OMAP2/3 using irq_domain_add_legacy().
> > 
> > A FIXME note was added so people know to delete that
> > code once that legacy DMA driver is fixed up.
> > 
> > Fixes: 55601c9f2467 (arm: omap: intc: switch over to linear irq domain)
> > Cc: <stable@vger.kernel.org> # v3.18
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Tested-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/irqchip/irq-omap-intc.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> Applied to irqchip/urgent.  Thanks for taking care of the Fixes and
> stable tags!

Jason, I'm not seeing this merged into v3.19-rc5, seems to be
in Linux next though.

Regards,

Tony
