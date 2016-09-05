From: po.liu@nxp.com (Po Liu)
Date: Mon, 5 Sep 2016 06:05:49 +0000
Subject: [PATCH v4 2/2] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
In-Reply-To: <20160902151725.GA25273@rob-hp-laptop>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
 <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <20160902151725.GA25273@rob-hp-laptop>
Message-ID: <VI1PR0401MB1709ED029763A20726FF5CD392E60@VI1PR0401MB1709.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


Best regards,
Liu Po

>  -----Original Message-----
>  From: Rob Herring [mailto:robh at kernel.org]
>  Sent: Friday, September 02, 2016 11:17 PM
>  To: Po Liu
>  Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>  linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Bjorn Helgaas;
>  Shawn Guo; Marc Zyngier; Roy Zang; Mingkai Hu; Stuart Yoder; Yang-Leo Li;
>  Arnd Bergmann; Minghuan Lian; Murali Karicheri
>  Subject: Re: [PATCH v4 2/2] pci:aer: add support aer interrupt with none
>  MSI/MSI-X/INTx mode
>  
>  On Wed, Aug 31, 2016 at 02:37:22PM +0800, Po Liu wrote:
>  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
>  > When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
>  > maybe there is interrupt line for aer pme etc. Search the interrupt
>  > number in the fdt file. Then fixup the dev->irq with it.
>  >
>  > Signed-off-by: Po Liu <po.liu@nxp.com>
>  > ---
>  > Changes for v4:
>  > 	- re-use the patch changes in the root port driver;
>  > 	- add binding information;
>  >
>  >  .../devicetree/bindings/pci/layerscape-pci.txt     |  4 +--
>  >  drivers/pci/pcie/portdrv_core.c                    | 31
>  +++++++++++++++++++---
>  >  2 files changed, 30 insertions(+), 5 deletions(-)
>  >
>  > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > index 41e9f55..1dfb1da 100644
>  > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
>  > @@ -19,7 +19,7 @@ Required properties:
>  >  - interrupts: A list of interrupt outputs of the controller. Must
>  contain an
>  >    entry for each entry in the interrupt-names property.
>  >  - interrupt-names: Must include the following entries:
>  > -  "intr": The interrupt that is asserted for controller interrupts
>  > +  "aer": The interrupt that is asserted for aer interrupts
>  
>  You can't just change this. That breaks compatibility with old dts files.
>  Plus, it is just a name. Why does it even matter? Not to mention having
>  the name for a single irq is a bit pointless.
Sorry, this binding comments maybe not clear. 
"aer" is just one of the interrupt names from host controller. There are "aer" "pme" and so on for further applications. 
This patch is to fix the Layerscape owning independent aer irq issue. So the 'aer' is used for this patch. The 'intr' will never be used, so removed.
I may remove the 'must include' for mis-understanding.

Thanks!

Po Liu

>  
>  Rob
