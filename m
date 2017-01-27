From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 10:41:33 +0100
Subject: [PATCH 1/2] nvmem: sunxi-sid: add support for H3 and A64's SID
 controller
In-Reply-To: <20170127122705.R0b4EAKp@smtp3o.mail.yandex.net>
References: <20170127122705.R0b4EAKp@smtp3o.mail.yandex.net>
Message-ID: <20170127094133.ewuf5uo6lb3vhf6k@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 05:26:59PM +0800, Icenowy Zheng wrote:
> > > +Example for sun8i-h3: 
> > > + sid at 01c14000 { 
> > > + compatible = "allwinner,sun8i-h3-sid"; 
> > > + /* 
> > > + * The length of SID on H3 is 0x100 bytes, add the value offset 
> > > + * 0x200, so the total length should be 0x300. 
> > > + */ 
> > > + reg = <0x01c14000 0x300>; 
> >
> > No, it should be the size of the memory region used and documented for 
> > that device, ie 1kB (0x400) in the H3 case, just like any other reg 
> > property. 
> 
> So bind the SID size with compatible?

If needed, yes.

> > > - randomness = kzalloc(sizeof(u8) * (size), GFP_KERNEL); 
> > > + randomness_size = max(size, SUNXI_SID_MAX_RANDOMNESS_SIZE); 
> > > + randomness = kzalloc(sizeof(u8) * (randomness_size), GFP_KERNEL); 
> >
> > Why is that change needed? 
> 
> On my H3/H2+ only 2 words after the first 4 words is not zero.
> 
> I don't feel like add so many 0s to randomness.

As far as I know, filling the entropy pool with zeros does no harm, it
just doesn't do anything either.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/b9bd8264/attachment.sig>
