From: gang.liu@nxp.com (Gang Liu)
Date: Sun, 12 Jun 2016 03:00:56 +0000
Subject: [PATCH] arm64: dts: ls1043a: Add 'dma-coherent' for ls1043a PCI
 nodes
In-Reply-To: <DB5PR0401MB192810622C64C85F08C281D9915E0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
 <1465282546-28256-2-git-send-email-Gang.Liu@nxp.com>
 <DB5PR0401MB192810622C64C85F08C281D9915E0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <DB4PR04MB2663122FB05EFC7BA1197D882520@DB4PR04MB266.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Scott Wood
> 
> On 06/07/2016 02:06 AM, Liu Gang wrote:
> > The 'dma-coherent' indicates that the hardware IP block can ensure the
> > coherency of the data transferred from/to the IP block. This can avoid
> > the software cache flush/invalid actions, and improve the performance
> > significantly.
> >
> > The PCI IP block of ls1043a has this capability, so adding this
> > feature to improve the PCI performance.
> >
> > Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Why not ls2080a as well?
[Liu Gang] ls2080 should also include this property, we can add it after verification.
 
> What about non-PCI devices?
> 
> Pretty much everything on these chips should be coherent as long as it's
> properly configured.
[Liu Gang] you are right. For the layerscape platforms including CCI or CCN internal bus,
theoretically, pretty much IP blocks (PCI/non-PCI) should be coherent. But this depends
on the properly hardware and software configurations. (ls1012a PCI devices cannot implement
the coherent duo to hardware issue)
So I think we'd better to add this property after each IP block's verification.

Thanks!
Liu Gang
>
> -Scott
