From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 17:22:02 +0000
Subject: [PATCH v3 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <1418292255.2315.12.camel@mtksdaap41>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <20141209101341.GV30369@pengutronix.de>
 <CABuKBe+whgVryssULCu2MAXRu3u+pYwM2nN3ToTEGpEvniQ6Jw@mail.gmail.com>
 <3015972.tvmzP0zTdv@wuerfel> <1418292255.2315.12.camel@mtksdaap41>
Message-ID: <20141215172202.GI11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 06:04:15PM +0800, Flora Fu wrote:
> On Tue, 2014-12-09 at 12:20 +0100, Arnd Bergmann wrote:

> > If it looks like i2c messages, would it be more appropriate to make
> > it appear as an i2c controller then?

> Although the message looks like I2C command, it is not I2C.
> Form source code, the software does not touch any I2C i/o or protocols.
> It depends SoC and has specific initial flow, read and write transfer
> state. It is not able to an i2c controller.

What Arnd is suggesting is that if the flow for using it is similar
enough to I2C you can push it through the I2C framework anyway even
though it'll never be possible to use it with generic devices.

> That's why we consider its a proprietary hardware with specific
> protocols. How about let it appear in driver/soc?

That's another option, though I'm not sure that's what the arm-soc
people are looking for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/864455a9/attachment-0001.sig>
