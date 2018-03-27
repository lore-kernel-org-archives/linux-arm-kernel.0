From: oss@buserror.net (Scott Wood)
Date: Tue, 27 Mar 2018 11:03:16 -0500
Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <VI1PR0402MB385456DB28FE27FCF9ACCAB997AC0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
References: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
 <20180323093408.230a61c1@bbrezillon>
 <VI1PR0402MB385456DB28FE27FCF9ACCAB997AC0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
Message-ID: <1522166596.5274.6.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-27 at 12:06 +0000, Prabhakar Kushwaha wrote:
> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> > Sent: Friday, March 23, 2018 2:04 PM
> > To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>;
> > robh at kernel.org
> > Cc: linux-mtd at lists.infradead.org; devicetree at vger.kernel.org;
> > mark.rutland at arm.com; shawnguo at kernel.org; boris.brezillon at free-
> > electrons.com; computersforpeace at gmail.com; oss at buserror.net; Leo Li
> > <leoyang.li@nxp.com>; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness
> > supports
> > 
> > You still haven't answered the comments I made on your v5. To me, this
> > does
> > not represent how the controller and chip pins are connected, but how the
> > chip was programmed and which endianness should be used by the
> > controller to correctly read the data back. Maybe I'm wrong, hence my
> > question.
> > 
> 
> NXP's ARM SoC has IFC module which interface with NOR flash. Here IFC is big
> endian module connected with NOR flash. 
> As SoC has ARM processor(Littler Endian),  CONFIG_MTD_CFI_BE_BYTE_SWAP needs
> to be enabled  to make sure data is read correctly.  
> This is the reason, I wrote about connection between controller and flash.
> 
> In a way, I agree with you.  It is not about connection. 
> It is about how controller read the data (inherently ARM processor)

It is not about anything inherent to ARM (which, like PPC, is a bi-endian
arch).  It's about the programming model of IFC on certain SoCs.

-Scott
