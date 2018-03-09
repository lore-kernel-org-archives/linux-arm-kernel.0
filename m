From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 9 Mar 2018 10:34:53 +0100
Subject: [PATCH] arm: dts: nes: add Nintendo NES Classic Edition support
In-Reply-To: <20180309091038.6jxuymerx5lgnh3y@flea.lan>
References: <20180307164336.32359-1-miquel.raynal@bootlin.com>
 <20180309082656.kglipdyu3knfq4ga@flea.lan>
 <20180309095814.5ea40afe@xps13>
 <20180309091038.6jxuymerx5lgnh3y@flea.lan>
Message-ID: <20180309103453.56e41ba8@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

> > > We want to support the default setup, and not require some hackery to
> > > be done. It will thus be some OTG / peripheral mode, most likely with
> > > an ID pin somewhere.

I would really appreciate to let the comment because with this kind of
boards, almost everything is hackery. Think about the SD card support.
Pins are there, but nothing is wired on it. However we still want to
let these pins available for it.

I can drop the mode = "host" property though.

> On Fri, Mar 09, 2018 at 09:58:14AM +0100, Miquel Raynal wrote:
> > > Since you tested on a SuperNES Classic, I think you should also create
> > > a new DT (possibly include it) with a compatible of its own.
> > > 
> > > That way, if we ever find some differences, it will be easy to deal
> > > with them.  
> > 
> > So, what you would prefer is:
> > 1/ Move this entire DTS but the usb_otg node into a
> > "sun8i-r16-nintendo-nes.dtsi"
> > 2/ Include that DTSI from a
> > "sun8i-r16-nintendo-super-nes-classic-edition.dts" that would add the
> > usb_otg node as it is above.  
> 
> My remark had nothing to do with USB OTG.

OK, sorry.

> You can just create a DT
> called sun8i-r16-nintendo-nes-classic.dts, and then create another one
> call sun8i-r16-nintendo-supernes-classic.dts that would include the
> former, only overriding the compatible.

And being almost empty then?

> 
> Maxime
> 



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
