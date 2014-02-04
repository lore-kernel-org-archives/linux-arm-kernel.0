From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 19:40:18 +0000
Subject: [PATCH v3 2/5] ASoC: tda998x: add a codec driver for the TDA998x
In-Reply-To: <20140204195921.5ace6163@armhf>
References: <cover.1391274627.git.moinejf@free.fr>
 <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
 <20140204133014.GA22609@sirena.org.uk>
 <20140204181605.5b837a70@armhf>
 <20140204175410.GL22609@sirena.org.uk>
 <20140204195921.5ace6163@armhf>
Message-ID: <20140204194018.GX22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 07:59:21PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > You shouldn't be representing this as a separate node in the DT unless
> > there really is a distinct and reusable IP, otherwise you're putting
> > Linux implementation details in there.  Describe the hardware, not the
> > implemementation.

> If there is no 'compatible' node for the tda998x CODEC in the DT, the
> simple-card is not usable, simply because you want the CODEC DAIs to be
> defined by 'phandle + index' instead of by DAI name.

This is a bit circular, though - it's only happening because you decided
to push everything onto a subnode in the DT.  If you just work with the
existing device this is no different to any other device.

> > > I don't understand. The tda CODEC can only be used with the TDA998x I2C
> > > driver. It might have been included in the tda998x source as well.

> > You shouldn't have the default settings there at all, that's not the
> > normal idiom for MFDs.  I'd also not expect to have to build the CODEC
> > driver just because I built the DRM component.

> As the tda998x handles audio in HDMI, it would be a pity if you should
> connect an other cable to your screen.

My screen doesn't have any speakers anyway :P (I'm writing this on a
computer with the monitor connected via HDMI).  Besides, this is more
about build coverage stuff than anything else.

> So, as I understand from your remarks, the CODEC should be included in
> the tda998x driver, and, then, as the simple-card cannot be used, there
> should be a Cubox specific audio card driver for the (kirkwood audio +
> tda998x HDMI + S/PDIF) set. Am I right?

No, it shouldn't be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/3a6f5542/attachment.sig>
