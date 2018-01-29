From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 29 Jan 2018 22:19:51 +0100
Subject: [PATCH] dt-bindings: Nokia N9 audio support
In-Reply-To: <20180119201546.v4ua72kejql3w2ro@rob-hp-laptop>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd> <20180110085315.GA17841@amd>
 <20180119201546.v4ua72kejql3w2ro@rob-hp-laptop>
Message-ID: <20180129211636.GA3873@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> > @@ -0,0 +1,36 @@
> > +Texas Instruments - wl1273 radio/bluetooth module
> 
> bluetooth chips have a binding location: bindings/net/bluetooth.
> 
> And we already have a WL1273 binding. Plus there's the one for the Nokia 
> BT which I think can be TI chips with a different firmware and protocol. 
> Is this related?

Ok, let me investigate wl1273 (and postpone it, audio is critical, FM
radio -- not so much).

> > index 0000000..230b1eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> > @@ -0,0 +1,32 @@
> > +* Nokia N9/N950 audio setup
> > +
> > +Required properties:
> > +- compatible: "nokia,n9-audio"
> > +
> > +- nokia,twl4030-cpu-dai: phandle for the McBSP node connected to TWL4030
> > +- nokia,tlv320dac33-cpu-dai: phandle for the McBSP node connected to TLV320DAC33
> > +- nokia,wl1273-cpu-dai: phandle for the McBSP node connected to WL1273
> > +
> > +- nokia,twl4030-codec: phandle for the TWL4030 codec
> > +- nokia,tlv320dac33-codec: phandle for the TLV320DAC33 codec
> > +- nokia,wl1273-codec: phandle for the WL1273 codec
> 
> Both dais and codecs should just be lists with a defined order.
> 
> > +- nokia,headphone-amplifier: phandle for the TPA6130A2 node
> 
> The simple card or graph card binding don't work? At least follow them 
> to the extent that they do work. 

Yep, that quite big changes for the driver... Thanks for pointers. I'm
not sure what features simple card / graph card miss. 

> > +Texas Instruments - tlv320dac33 Codec module
> > +
> > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,tlv320dac33"
> > +- reg - I2C slave address
> > +
> > +Optional properties:
> > +
> > +- power-gpio - gpio pin to power the device
> 
> power-gpios.
> 
> Active high or low?

Ok, this one can be fixed easily, and I guess tlv320dac33 driver might
be useful for someone else, so I'll try to merge it first.

Thanks for review,

> > +	ti,burst-bclkdiv = /bits/ 8 <3>;

Oh and I'll make this plain int. No need to play with bits.

Best regards
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/f37f00db/attachment.sig>
