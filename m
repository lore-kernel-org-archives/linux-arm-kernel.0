From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jun 2012 12:18:47 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <20120622161155.GM4037@opensource.wolfsonmicro.com>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
 <20120622131750.GB19226@n2100.arm.linux.org.uk>
 <20120622161155.GM4037@opensource.wolfsonmicro.com>
Message-ID: <20120625111847.GE19226@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 05:11:56PM +0100, Mark Brown wrote:
> On Fri, Jun 22, 2012 at 02:17:51PM +0100, Russell King - ARM Linux wrote:
> 
> > I suspect the key difference is I run the uImage kernels on the SDP4430
> > without a DT blob.  I suspect it's the DT conversion of sound/soc/omap
> > that's buggered it up.
> 
> This sounds like the most likely explanation.  There's not that many
> commits, would it be possible for you to try bisecting them (or just
> reverting them one at a time)?  The most salient ones should be:
> 
> 356bccbea17988bd32a016ada867dd6a53ba2796 ASoC: omap-abe-twl6040: Introduce driver data for runtime parameters
> 7d09f9e98956b29755f20d830252dec9300e7044 ASoC: omap-abe-twl6040: Move Digital Mic widget into dapm table
> c2f98956e3635a897737cc08a60539752aa00dd7 ASoC: omap-abe-twl6040: Keep only one snd_soc_dai_link structure
> 
> though it looks like a bisect of sound/soc/omap should be about as fast.
> Like I say if we're talking late July or August there's a very good
> chance that 3.5 will be broken so we should at least revert but it'd be
> a shame to loose the HDMI stuff, I'd really expect that to be unrelated.

It appears to be something to do with the jack detection that's going wrong.
If I start the audio with the jack disconnected, I never get anything out
of the board.  It requires the jack to be connected before the first use.
The on-board speakers used to work without the jack plugged in at one time
but they seem to be completely non-functional now.

Confused.
