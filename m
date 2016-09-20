From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Sep 2016 20:39:26 +0800
Subject: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
In-Reply-To: <VI1PR0401MB1709F91B0C1EB6C80D741E4492F50@VI1PR0401MB1709.eurprd04.prod.outlook.com>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
 <1473741659-17618-1-git-send-email-po.liu@nxp.com>
 <1473741659-17618-3-git-send-email-po.liu@nxp.com>
 <20160918005212.GF15478@tiger>
 <VI1PR0401MB1709F91B0C1EB6C80D741E4492F50@VI1PR0401MB1709.eurprd04.prod.outlook.com>
Message-ID: <20160920123926.GA3744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 03:37:27AM +0000, Po Liu wrote:
> Hi Shawn,
> 
> 
> >  -----Original Message-----
> >  From: Shawn Guo [mailto:shawnguo at kernel.org]
> >  Sent: Sunday, September 18, 2016 8:52 AM
> >  To: Po Liu
> >  Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >  linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Roy Zang; Arnd
> >  Bergmann; Marc Zyngier; Stuart Yoder; Leo Li; M.H. Lian; Murali
> >  Karicheri; Bjorn Helgaas; Mingkai Hu
> >  Subject: Re: [PATCH v5 3/3] pci:aer: add support aer interrupt with none
> >  MSI/MSI-X/INTx mode
> >  
> >  On Tue, Sep 13, 2016 at 12:40:59PM +0800, Po Liu wrote:
> >  > On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> >  > When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
> >  > maybe there is interrupt line for aer pme etc. Search the interrupt
> >  > number in the fdt file. Then fixup the dev->irq with it.
> >  >
> >  > Signed-off-by: Po Liu <po.liu@nxp.com>
> >  
> >  Will the new kernel work with existing/old DTB?  I'm trying to
> >  understand the dependency between driver and DTS changes.
> 
> Yes, We've never use name 'intr' before. So we remove it is ok. 
> 'aer' is a dts name for researching it's true interrupt number by kernel. This patch is first time to use name 'aer'. So it must be compatible with existing/old DTB.

Does that mean driver and DTS changes can go through separate trees,
i.e. PCI and arm-soc, without introducing regressions on either tree?
Or does the patch series needs to go in as a whole?

Shawn
