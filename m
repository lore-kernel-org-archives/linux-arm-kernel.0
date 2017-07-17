From: jingoohan1@gmail.com (Jingoo Han)
Date: Mon, 17 Jul 2017 15:32:43 -0400
Subject: [PATCH] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to check
 enabled or not
In-Reply-To: <1df044ef-1daf-0b60-da30-a6a45215f275@synopsys.com>
References: <20170713103527.1642-1-jszhang@marvell.com>
 <1df044ef-1daf-0b60-da30-a6a45215f275@synopsys.com>
Message-ID: <000b01d2ff33$76d4fad0$647ef070$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 17, 2017 5:28 AM, Joao Pinto wrote:
> 
> Hi,
> 
> ?s 11:35 AM de 7/13/2017, Jisheng Zhang escreveu:
> > The ATU CTRL2 register is 32 bit, besides the enable bit, other bits
> > may also be set. To check whether the ATU is enabled or not, we should
> > test the enable it.

To Jisheng Zhang,

typo s/it/bit

"test the enable it."  ---> "test the enable bit."


Please fix this typo, and send it again.
Type is confusing.


Best regards,
Jingoo Han


> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/pci/dwc/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-
> designware.c
> > index 0e03af279259..6bf0b409050a 100644
> > --- a/drivers/pci/dwc/pcie-designware.c
> > +++ b/drivers/pci/dwc/pcie-designware.c
> > @@ -177,7 +177,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index, int type,
> >  	 */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++)
> {
> >  		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
> > -		if (val == PCIE_ATU_ENABLE)
> > +		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >
> >  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> >
> Make sense, turn it more accurate. Thanks!
> 
> Acked-by: Joao Pinto <jpinto@synopsys.com>
