From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 23:50:29 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <20131014174030.GU25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
 <20131014174030.GU25034@n2100.arm.linux.org.uk>
Message-ID: <20131014225029.GV25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 06:40:30PM +0100, Russell King - ARM Linux wrote:
> Another thing that my build testing (and use on cubox-i) picked up:
> 
> On Thu, Oct 03, 2013 at 03:51:26PM -0300, Fabio Estevam wrote:
> > diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> > index 9e8ae11..65e54b4 100644
> > --- a/arch/arm/boot/dts/imx6dl.dtsi
> > +++ b/arch/arm/boot/dts/imx6dl.dtsi
> > @@ -88,3 +88,7 @@
> >  		crtcs = <&ipu1 0>, <&ipu1 1>;
> >  	};
> >  };
> > +
> > +&hdmi {
> > +	crtcs = <&ipu1 0>, <&ipu1 1>;
> > +}
> 
> Missing semi-colon.

Okay, next question(s).

1. How well tested is any of this imx-drm stuff?

2. What sort of testing has it been subject to?

Answers to these two questions may help stop me wasting a lot of time
chasing what is a really weird bug.

So, I have X up and running on the Cubox-i carrier-1, using the imx-drm
stuff (I've slightly hacked my xf86-armada X driver to get this working.)
This works fine - it detects the connectors, selects an appropriate
video mode and produces a picture of the correct shape and size.

However... I see really weird effects colouring effects - almost like
water over the image.  It's certain colour transitions in the image
which seem to trigger this.  There are also certain pixels which
"twinkle".

Text looks very strange too.  Rather than the font being crisp and clear,
it looks like there's red and green shift to it - but its not that it's
all shifted in that way.

Now, if I use the modetest utility from libdrm-2.4.43 to display a SMPTE
test pattern, this again looks right, but there are several vertical
single pixel lines of noise.  The most striking one is below the upper
red bar in the lower dark area.  I have a single pixel noisy vertical
line.

I've tried the kernel which Rabeeh supplied, which is based on BSP 4.1.0,
and this works fine as far as I can tell with the same image (though,
it's a little difficult converting the XWD dump to something that can
be directly poked into /dev/fb0..., although this results in R/B swap.)

Any ideas where to start looking?
