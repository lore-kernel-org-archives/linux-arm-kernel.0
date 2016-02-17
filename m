From: mingkai.hu@nxp.com (Mingkai Hu)
Date: Wed, 17 Feb 2016 02:17:47 +0000
Subject: [PATCH] PCI: layerscape: add ls2085a compatible
In-Reply-To: <20160205222525.GA16238@localhost>
References: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
 <20160205203858.GA11780@localhost> <56B509E5.2050602@linaro.org>
 <20160205222525.GA16238@localhost>
Message-ID: <VI1PR04MB1454676391D9A2D83E7625F48EAE0@VI1PR04MB1454.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Saturday, February 06, 2016 6:25 AM
> To: Shi, Yang
> Cc: Mingkai.Hu at freescale.com; Minghuan.Lian at freescale.com;
> bhelgaas at google.com; linux-pci at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linaro-
> kernel at lists.linaro.org; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala; devicetree at vger.kernel.org
> Subject: Re: [PATCH] PCI: layerscape: add ls2085a compatible
> 
> On Fri, Feb 05, 2016 at 12:45:25PM -0800, Shi, Yang wrote:
> > On 2/5/2016 12:38 PM, Bjorn Helgaas wrote:
> > >[+cc Rob, et al]
> > >
> > >On Wed, Jan 27, 2016 at 09:32:05AM -0800, Yang Shi wrote:
> > >>The layerscape PCI host driver needs recognize ls2085a compatible
> > >>when using firmware with ls2085a compatible property, otherwise the
> > >>PCI bus won't be detected even though ls2085a compatible is included
> by the dts.
> > >>
> > >>Signed-off-by: Yang Shi <yang.shi@linaro.org>
> > >>---
> > >>  drivers/pci/host/pci-layerscape.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >>diff --git a/drivers/pci/host/pci-layerscape.c
> > >>b/drivers/pci/host/pci-layerscape.c
> > >>index 3923bed..c40d8b2 100644
> > >>--- a/drivers/pci/host/pci-layerscape.c
> > >>+++ b/drivers/pci/host/pci-layerscape.c
> > >>@@ -203,6 +203,7 @@ static const struct of_device_id
> ls_pcie_of_match[] = {
> > >>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> > >>  	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> > >>  	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> > >>+	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> > >
> > >Hmm, "fsl,ls2085a-pcie" doesn't appear in
> > >Documentation/devicetree/bindings/pci/.
> > >
> > >Aren't we supposed to add these strings to the bindings before or at
> > >the same time we add them to drivers?
> >
> > The below patch will add it into dts and binding doc. I should
> > mentioned this in the commit log.
> >
> > https://patchwork.kernel.org/patch/7767061/
> 
> OK.  This is really annoying as a reviewer.  To me, adding "fsl,ls2085a-
> pcie" to:
> 
>   - the binding in Documentation/devicetree/bindings/pci/layerscape-
> pci.txt
>   - the DT in arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>   - the driver in drivers/pci/host/pci-layerscape.c
> 
> are all logically related, and it would make sense to have them all in a
> single patch.
> 
> But whatever.  I applied this to pci/host-layerscape for v4.6.
> 

Bojon,

I have sent version3 of the patch to add strings to the bindings and dts file.
https://patchwork.kernel.org/patch/8333761/

Sorry for the delayed response due to Chinese New Year holiday.

Thanks,
Mingkai
