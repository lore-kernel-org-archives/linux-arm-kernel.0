From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Oct 2013 00:20:57 -0300
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <20131014225029.GV25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
 <20131014174030.GU25034@n2100.arm.linux.org.uk>
 <20131014225029.GV25034@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DWa8UjzToTuhqH_1ZuRiUXvjp8HOZaw0b1C8ah-+EdGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 7:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Okay, next question(s).
>
> 1. How well tested is any of this imx-drm stuff?
>
> 2. What sort of testing has it been subject to?

Most of my tests with the imx-drm driver have been through the LVDS
panel so far.

For HDMI, I haven't gone through too much of testing yet, only basic
raw framebuffer at full HD resolution.

I know Tony/Robert (and Sascha) and some folks at the Wandboard
mailing list have also tested HDMI with the previous version of the
HDMI driver that was posted by Tony.

> Answers to these two questions may help stop me wasting a lot of time
> chasing what is a really weird bug.
>
> So, I have X up and running on the Cubox-i carrier-1, using the imx-drm
> stuff (I've slightly hacked my xf86-armada X driver to get this working.)
> This works fine - it detects the connectors, selects an appropriate
> video mode and produces a picture of the correct shape and size.
>
> However... I see really weird effects colouring effects - almost like
> water over the image.  It's certain colour transitions in the image
> which seem to trigger this.  There are also certain pixels which
> "twinkle".
>
> Text looks very strange too.  Rather than the font being crisp and clear,
> it looks like there's red and green shift to it - but its not that it's
> all shifted in that way.
>
> Now, if I use the modetest utility from libdrm-2.4.43 to display a SMPTE
> test pattern, this again looks right, but there are several vertical
> single pixel lines of noise.  The most striking one is below the upper
> red bar in the lower dark area.  I have a single pixel noisy vertical
> line.

Ok, interesting. Will run a video test pattern via gstreamer
videotestsrc plugin to see how it behaves.

I am travelling tomorrow, so it will be at last in 2 weeks that I will
be able to access a mx6 hardware.

In the meantime, maybe one of the folks in Cc could share some ideas.

Regards,

Fabio Estevam
