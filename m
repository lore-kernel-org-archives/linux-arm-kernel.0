From: marex@denx.de (Marek Vasut)
Date: Wed, 20 Nov 2013 16:11:43 +0100
Subject: [RESEND PATCH 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
In-Reply-To: <20131120145907.GA28946@htj.dyndns.org>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
 <1384943242-8201-1-git-send-email-marex@denx.de>
 <20131120145907.GA28946@htj.dyndns.org>
Message-ID: <201311201611.44120.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tejun,

> On Wed, Nov 20, 2013 at 11:27:22AM +0100, Marek Vasut wrote:
> > We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> > Linux will fail to find the attached drive on some boards.
> > 
> > This entire fix was:
> > Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Linux-IDE <linux-ide@vger.kernel.org>
> > ---
> > 
> >  drivers/ata/ahci_imx.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > RESEND: Fix the Cc here.
> > 
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index ae2d73f..478921b 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -125,6 +125,7 @@ static int imx6q_sata_init(struct device *dev, void
> > __iomem *mmio)
> > 
> >  			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
> >  			| IMX6Q_GPR13_SATA_TX_LVL_MASK
> >  			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> > 
> > +			| IMX6Q_GPR13_SATA_MPLL_CLK_EN
> > 
> >  			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
> >  			
> >  			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
> >  			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
> 
> Not your fault but when things stretch over multiples lines, the
> convention is to put the operators and commas at the end of each line
> not the other way around.  I'd appreciate if you add a trivial patch
> to update that too.

It's already done in 2/6 of the series, I hope that is OK. Otherwise I can 
separate this formating change from the 2/6 patch and shove it in front of this 
one even. Which one do you prefer please?

Best regards,
Marek Vasut
