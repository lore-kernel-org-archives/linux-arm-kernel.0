From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 27 Mar 2018 14:12:54 +0200
Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <VI1PR0402MB385456DB28FE27FCF9ACCAB997AC0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
References: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
 <20180323093408.230a61c1@bbrezillon>
 <VI1PR0402MB385456DB28FE27FCF9ACCAB997AC0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
Message-ID: <20180327141254.56051a74@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2018 12:06:41 +0000
Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:

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
> > On Mon, 12 Mar 2018 13:41:28 +0530
> > Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:
> >   
> > > Connection between flash and controller is not necessary to be always
> > > of same type. It may varies from platform to platform.
> > >
> > > Adding endianness (optional) property to provide connection type
> > > information.
> > >
> > > Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes for v2: updated subject
> > > Changes for v3: fixed typo for "big-endian"
> > > Changes for v4: Moved binding definition in mtd-physmap.txt as
> > > discussed at
> > >  
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat  
> > >  
> > chwork.ozlabs.org%2Fpatch%2F842543%2F&data=02%7C01%7Cprabhakar.ku
> > shwah  
> > >  
> > a%40nxp.com%7C4e3c62614d144bdbb76408d59098d999%7C686ea1d3bc2b4c
> > 6fa92cd  
> > >  
> > 99c5c301635%7C0%7C0%7C636573908516332353&sdata=Od7aqu%2BqV4RHB
> > EmT08UOb  
> > > H2EFGgWmGfftCRKlOlj1kY%3D&reserved=0
> > > Changes for v5: Sending as it is
> > > Changes for v6: Updated binding when endianness property is absent
> > >
> > >  Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> > > b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> > > index 4a0a48bf4ecb..691c98f7301d 100644
> > > --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> > > +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> > > @@ -41,6 +41,11 @@ additional (optional) property is defined:
> > >
> > >   - erase-size : The chip's physical erase block size in bytes.
> > >
> > > + The device tree may optionally contain endianness property.
> > > + little-endian or big-endian : It represents connection between
> > > + controller and  
> > 
> > You still haven't answered the comments I made on your v5. To me, this does
> > not represent how the controller and chip pins are connected, but how the
> > chip was programmed and which endianness should be used by the
> > controller to correctly read the data back. Maybe I'm wrong, hence my
> > question.
> >   
> 
> NXP's ARM SoC has IFC module which interface with NOR flash. Here IFC is big endian module connected with NOR flash. 
> As SoC has ARM processor(Littler Endian),  CONFIG_MTD_CFI_BE_BYTE_SWAP needs to be enabled  to make sure data is read correctly.  
> This is the reason, I wrote about connection between controller and flash.
> 
> In a way, I agree with you.  It is not about connection. 
> It is about how controller read the data (inherently ARM processor)
> 
> So I am planning to write below text
> little-endian or big-endian: It represents endianness of controller for correct data reading from flash.

"
 Represents the endianness that should be used by the controller to
 properly read/write data from/to the flash.
"

>                                                  If this property is missing, the endianness is chosen by the system (potentially based
>                                                 on extra configuration options).

This part is good.

> 
> please let me know if above definition requires more changes. 
> 
> Regards,
> Prabhakar



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
