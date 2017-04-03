From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 22:59:53 +0200
Subject: [PATCH 6/15] dt-bindings: display: sun4i: Add HDMI display
 bindings
In-Reply-To: <20170315172622.lb6vy7cmbwaf7crn@rob-hp-laptop>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <f1d46b79f933df724a6750d557ebe9517b6339b5.1488876832.git-series.maxime.ripard@free-electrons.com>
 <20170315172622.lb6vy7cmbwaf7crn@rob-hp-laptop>
Message-ID: <20170403205953.vdf5ynyvktpiheax@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Mar 15, 2017 at 12:26:22PM -0500, Rob Herring wrote:
> > +HDMI Encoder
> > +------------
> > +
> > +The HDMI Encoder supports the HDMI video and audio outputs, and does
> > +CEC. It is one end of the pipeline.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun5i-a10s-hdmi
> > +  - reg: base address and size of memory-mapped region
> > +  - clocks: phandles to the clocks feeding the HDMI encoder
> > +    * ahb: the HDMI interface clock
> > +    * mod: the HDMI module clock
> > +    * pll-0: the first video PLL
> > +    * pll-1: the second video PLL
> > +  - clock-names: the clock names mentioned above
> > +
> > +  - ports: A ports node with endpoint definitions as defined in
> > +    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +    first port should be the input endpoint.
> 
> You need an output port to an HDMI connector node and an audio port.

I started to look at the audio, and I can't find a use for an audio
port in the OF graph. As far as I understand, we will be using the
hdmi-codec, that still requires an ASoC card to create the link
between our i2s controller and the HDMI controller.

This work perfectly for us, but as far as I know, the simple-card
stuff only requires a phandle, and not an OF graph endpoint, right?

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/bbc1266d/attachment.sig>
