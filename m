From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 16:27:44 +0100
Subject: [PATCH 1/5] arm64: dts: allwinner: a64: Add i2c0 pins
In-Reply-To: <E1evfa8-0000O7-0e@stardust.g4.wien.funkfeuer.at>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-2-harald@ccbib.org>
 <5b7f1a15-011f-c386-4813-f0fb8a91dfd8@arm.com>
 <E1evfa8-0000O7-0e@stardust.g4.wien.funkfeuer.at>
Message-ID: <20180313152744.fb2oo44v6lr4gyha@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 09:46:51AM +0100, Harald Geyer wrote:
> Andr? Przywara writes:
> > On 12/03/18 16:10, Harald Geyer wrote:
> > > Add the proper pin group node to reference in board files.
> > > 
> > > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > 
> > That looks correct to me, so:
> > 
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > But out of curiosity, what is this used for? In patch 5/5 I see it being
> > used, but without a clue for what? Shouldn't enabling an I2C node be
> > accompanied by some child node, presenting the device on the bus?
> > I guess this I2C is not on some kind of "header" on that laptop?
> 
> I enabled it because the ANX6345 eDP-bridge is on that bus. There is
> no linux (mainline) driver for this chip at the moment, the bootloader
> initializes it. However I'm using the i2c-dev driver to read (and maybe)
> change some register values from user space.
> 
> i2cdetect sees devices at 0x38, 0x39 and 0x3d - all of which might
> be the ANX6345. I haven't looked into this in detail.

That's alright then, just put a comment in the DT on what this bus is
used for.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/b2c7488d/attachment.sig>
