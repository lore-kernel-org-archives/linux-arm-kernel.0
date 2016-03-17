From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Mar 2016 18:11:57 +0100
Subject: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
In-Reply-To: <20160317170640.GB21009@rob-hp-laptop>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop>
Message-ID: <4107975.rId64mooHz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 12:06:40 Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> > similarity index 91%
> > rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
> > index b71b203..07adca9 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> > +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> > @@ -25,6 +25,9 @@ Recommended properties:
> >   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
> >     registers, for those SOCs that have a PAMU device.
> >  
> > + - little-endian : Indicates that the global utilities block is little
> > +   endian. The default is big endian.
> 
> The default is "the native endianness of the system".

This may be what is currently documented, but not what we are doing
in practice, as there is no "native endianess" for either PowerPC or
ARM -- both allow running big-endian or little-endian kernels and the
device registers are fixed.

I think the property here is fine.

	Arnd
