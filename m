From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Aug 2013 15:56:44 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805144054.GE9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
Message-ID: <20130805145644.GV23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 03:40:54PM +0100, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:
> 
> > > This doesn't look good - this is adding DAPM routes which should
> > > correspond to the DAI link that's already been configured.
> 
> > No, you're wrong there:
> 
> > CPU DAI:				Codec DAI
> > dma-playback	--->	i2sdo	--->	Playback
> > 		`-->	spdifdo -> not connected
> > dma-capture	<---	i2sdi	<---	Capture
> 
> > And the intermediate level is needed to determine which outputs from
> > the chip are wired up.
> 
> Right, and that's exactly what the dai_links are doing - they're showing
> what's hanging off each of the DAIs.
> 
> > And don't even say "use dpcm" - if you say that, I want _you_ to write
> > it because dpcm is totally and utterly unusable as it currently stands -
> > as you can see from all the emails I've sent over the weekend.
> 
> I'm going to tell you to work with the framework rather than around it;

Work with the fscking undocumented framework.  If you want that, then
sodding well document this pile of crap.  If not, stop telling people
to "work around it".

> adding routes that link the CODEC and CPU together in parallel with the
> links set up for the DAIs is not something that seems like it's going to
> continue to work sensibly going forwards.

So you're *TOTALLY* missing why I've had to do that.  Tell me, how can
the CPU DAI detect which of its frigging outputs are connected to the
codec without doing the above?  Show me how your crappy subsystem is
supposed to work.  Document the sodding thing.

If you don't do this, don't expect people to understand it.  Don't
expect people not to find "other solutions" around the utter shite that
I've had to deal with ALL FRIGGING WEEKEND.

These patches stay as they are until you get a clue about what's required
to drive this hardware and start providing some sensible assistance with
your undocumented code.
