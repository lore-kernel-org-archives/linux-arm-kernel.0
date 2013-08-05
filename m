From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 15:59:56 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FFA348.2010503@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com>
Message-ID: <20130805145955.GW23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 03:06:16PM +0200, Sebastian Hesselbarth wrote:
> And that is what will be true for almost all codecs we hook up on
> Marvell SoCs. The audio controller is very simple with only mute
> control available. We need to connect either i2s or spdif or both to
> any codec and the codecs output. The codecs is determined by phandle
> and the output (codec_dai_name) could be determined by the phandle's
> arg, e.g. 0 for the first codec_dai provided.

Sebastian,

I suggest just not fucking bothering with this.  Mark has no intention
to listen to what we need to make SPDIF and I2S work on this hardware,
so persuing getting this stuff into mainline is just a total and utter
waste of time.

Maybe when Mark stops being an arsehole and starts trying to understand
what people need from ASoC, and he starts documenting this stuff, it
might be possible to resurect this, but quite frankly with his attitude
towards people trying to use his code, I think we're probably far better
off dumping ASoC and going in at the ALSA level instead.

I've had enough of ASoC crap.
