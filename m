From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Dec 2017 19:53:08 +0100
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
In-Reply-To: <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
 <20171206153205.k3l5sofdco3t75mi@flea.lan>
 <20171206154810.eb2czpb4kusxv5kj@sirena.org.uk>
Message-ID: <20171206185308.ijt76lodwgkz2pm3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 03:48:10PM +0000, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 04:32:05PM +0100, Maxime Ripard wrote:
> 
> > BCLK is sample rate * sample size * channels, and LRCK is running at
> > the sample rate. So the ratio is the sample size * channels.
> 
> > Anything deviating from those standard i2s concepts should at least be
> > documented, with arguments to back them off.
> 
> BCLK can be higher than the minimum there in most formats, though some
> hardware is more restrictive so we tend to go for the minimum clock rate.

How does that work in such a case? Is LRCK faster as well, and we're
keeping the same ratio, or will the codec buffer the current sample
until the next word?

Is it usually a property of the codec or the DAI?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/74219ba6/attachment-0001.sig>
