From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Dec 2017 19:13:11 +0000
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <20171206185308.ijt76lodwgkz2pm3@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
 <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
 <20171206185308.ijt76lodwgkz2pm3@flea.lan>
Message-ID: <20171206191311.7wlvqiolpho4zvxh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 07:53:08PM +0100, Maxime Ripard wrote:
> On Wed, Dec 06, 2017 at 03:48:10PM +0000, Mark Brown wrote:

> > BCLK can be higher than the minimum there in most formats, though some
> > hardware is more restrictive so we tend to go for the minimum clock rate.

> How does that work in such a case? Is LRCK faster as well, and we're
> keeping the same ratio, or will the codec buffer the current sample
> until the next word?

No, the extra clock cycles just get ignored - most of the formats define
the location of the data in terms of LRCLK edges, any extra BCLK edges
shouldn't do anything.

> Is it usually a property of the codec or the DAI?

Things that require extra cycles for some reason tend to be CODECs, but
this can also be done just because whatever the clock master is doesn't
have very flexible dividers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/62f7abdd/attachment.sig>
