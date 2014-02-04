From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 19:54:47 +0000
Subject: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the
 tda998x CODEC
In-Reply-To: <20140204200239.1baf309b@armhf>
References: <cover.1391274627.git.moinejf@free.fr>
 <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
 <20140204181213.GO22609@sirena.org.uk>
 <20140204200239.1baf309b@armhf>
Message-ID: <20140204195447.GY22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 08:02:39PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > On Sat, Feb 01, 2014 at 05:48:49PM +0100, Jean-Francois Moine wrote:

> > > +	- compatible: must be "nxp,tda998x-codec".

> > It's not clear to me why there's a separate compatible here - as far as
> > I can see this can only appear as part of one of these devices and
> > there's no addressing or other information that'd account for chip
> > variation so I'd not expect to need to bind this independently of the
> > parent.

> If there is no 'compatible', the CODEC module is not loaded, and, when
> the module is in the core, no CODEC device can be created from the DT.

You're confusing implementation details with device tree specification
here.  We can easily handle loading a subdriver without having to put
anything in the device tree, just create a platform device like we do
with MFDs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/3713efb2/attachment.sig>
