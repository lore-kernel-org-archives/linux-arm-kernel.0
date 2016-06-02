From: po.liu@nxp.com (Po Liu)
Date: Thu, 2 Jun 2016 01:17:24 +0000
Subject: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name property
 in the dts
In-Reply-To: <20160601143950.GA1817@rob-hp-laptop>
References: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
 <20160601143950.GA1817@rob-hp-laptop>
Message-ID: <VI1PR0401MB1709DFD5A437FD01D724FF9F92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  -----Original Message-----
>  From: Rob Herring [mailto:robh at kernel.org]
>  Sent: Wednesday, June 01, 2016 10:40 PM
>  To: Po Liu
>  Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>  linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Shawn Guo;
>  Marc Zyngier; Roy Zang; Mingkai Hu; Stuart Yoder; Yang-Leo Li; Arnd
>  Bergmann; Bjorn Helgaas; Minghuan Lian
>  Subject: Re: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name
>  property in the dts
>  
>  On Thu, May 26, 2016 at 01:59:09PM +0800, Po Liu wrote:
>  > Freescale some platforms aer interrupt was not MSI/MSI-X/INTx
>  
>  some or all?

For all Layerscape platforms, that should be clear, sorry.

>  
>  > but using interrupt line independently. This patch add a "aer"
>  > interrupt-names for aer interrupt.
>  
>  You are not adding, but replacing the interrupt. This needs a better
>  explanation as you are breaking compatibility.

We used to the "intr" name for general concept, but no use. So removed.
In the Layerscape platform, the aer and pme interrupt lines are independent, 
not in the Complex Root by MSI or MSIX, so need to read from the DTS before
MSIX and MSI searching for pci service driver.
 
>  
>  Rob
