From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 15:40:54 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805113310.GU23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
Message-ID: <20130805144054.GE9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:

> > This doesn't look good - this is adding DAPM routes which should
> > correspond to the DAI link that's already been configured.

> No, you're wrong there:

> CPU DAI:				Codec DAI
> dma-playback	--->	i2sdo	--->	Playback
> 		`-->	spdifdo -> not connected
> dma-capture	<---	i2sdi	<---	Capture

> And the intermediate level is needed to determine which outputs from
> the chip are wired up.

Right, and that's exactly what the dai_links are doing - they're showing
what's hanging off each of the DAIs.

> And don't even say "use dpcm" - if you say that, I want _you_ to write
> it because dpcm is totally and utterly unusable as it currently stands -
> as you can see from all the emails I've sent over the weekend.

I'm going to tell you to work with the framework rather than around it;
adding routes that link the CODEC and CPU together in parallel with the
links set up for the DAIs is not something that seems like it's going to
continue to work sensibly going forwards.  If this were done at a
framework level that should be fine but having it as a special case in
some specific boards isn't good.

Since I don't have Kirkwood hardware or any particular use for it I've
no real intention of working on the hardware directly, sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/394a3b8d/attachment-0001.sig>
