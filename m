From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Sep 2014 11:48:51 +0100
Subject: [PATCH 1/2] ASoC: rockchip-max98090: add documentation for
 rockchip-max98090 driver
In-Reply-To: <54275C43.8010205@rock-chips.com>
References: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
 <1410507036-15442-1-git-send-email-jay.xu@rock-chips.com>
 <20140912134446.GT7960@sirena.org.uk>
 <54275C43.8010205@rock-chips.com>
Message-ID: <20140928104851.GR27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28, 2014 at 08:54:27AM +0800, Jianqun wrote:

Please fix your mailer to word wrap within paragraphs.

> ? 09/12/2014 09:44 PM, Mark Brown ??:
> > On Fri, Sep 12, 2014 at 03:30:36PM +0800, Jianqun wrote:
> >> Add documentation for rockchip-max98090 driver, which is need by rockchip
> >> board using a max98090.

> > Can this use simple-card (perhaps after a bit of extension)?
> I haven't ever try simple-card, is there any sample usage for me from other vendor ?

$ git grep -l simple-audio-card
Documentation/devicetree/bindings/sound/simple-card.txt
arch/arm/boot/dts/kirkwood-openrd-client.dts
arch/arm/boot/dts/kirkwood-t5325.dts
arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
arch/arm/boot/dts/vf610-twr.dts
sound/soc/generic/simple-card.c

> >> +- rockchip,audio-codec : The phandle of the MAX98090 audio codec.

> > Is the driver really specific to this CODEC?

> I think yes, we need to add two gpio for mic and hp detect, but simple-card driver hasn't them

That'd be the "possibly with some extensions" bit then...  if they're
just isolated GPIOs there's not really much board specific about having
them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140928/d45d1b53/attachment.sig>
