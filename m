From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jul 2015 19:40:43 +0100
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk>
 <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
Message-ID: <20150729184043.GL11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 08:21:34PM +0200, Michal Suchanek wrote:
> On 29 July 2015 at 19:16, Mark Brown <broonie@kernel.org> wrote:

> >> It will not break anything. It will just spam dmesg.

> > I'm confused - if all this change does is to spam dmesg then what's the
> > point?

> Presumably when your SPI NOR flash fails to probe this message will be
> just above and you will look into the binding doc and add the
> compatible.

If you're looking to add a warning message when the flash device fails
to probe then add that in the flash driver when it detects an error,
this will cause needless noise for everyone else using this controller
purely to work around the broken binding.

And like I say compatible really seems like it isn't an appropriate
property here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/feb69d4f/attachment-0001.sig>
