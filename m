From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 15 Jun 2018 10:45:42 +0200
Subject: [linux-sunxi] Re: [PATCH v2 04/27] dt-bindings: display:
 sunxi-drm: Add TCON TOP description
In-Reply-To: <2481282.yoIGH2ksVh@jernej-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-5-jernej.skrabec@siol.net>
 <20180613073456.jk72zw4rt4ysjco7@flea>
 <2481282.yoIGH2ksVh@jernej-laptop>
Message-ID: <20180615084542.slp3ma4krrj744do@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 06:03:21PM +0200, Jernej ?krabec wrote:
> > > +Required properties:
> > > +  - compatible: value must be one of:
> > > +    * allwinner,sun8i-r40-tcon-top
> > > +  - reg: base address and size of the memory-mapped region.
> > > +  - clocks: phandle to the clocks feeding the TCON TOP
> > > +    * bus: TCON TOP interface clock
> > > +  - clock-names: clock name mentioned above
> > > +  - resets: phandle to the reset line driving the DRC
> > 
> > s/DRC/TCON TOP/ ?
> 
> Yes, copy & paste issue
> 
> > 
> > > +    * rst: TCON TOP reset line
> > 
> > Remaining consistent with the clock name would be great
> 
> You mean "ahb"? I noticed that most other nodes with reset lines don't have a 
> name associated. Maybe I could just drop it and use first specified reset?

It's called bus in the binding, but yes. And yeah, we can drop the
name as well.

> > 
> > > +  - reset-names: reset name mentioned above
> > > +  - #clock-cells : must contain 1
> > 
> > An example would be nice here
> 
> You mean node example? with ports? In the past, Rob was against examples 
> unless really necessary. Node from R40 DTSI can serve as an example.

Ok.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/6770fcf3/attachment.sig>
