From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jan 2016 16:04:21 +0000
Subject: [alsa-devel] [PATCH 0/9] dw-hdmi audio support
In-Reply-To: <CAH-u=810V863yYhMvvtaQ7jxNgrOXAL4bi1mS506a-yOTbuYhQ@mail.gmail.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <1440664941.3233.38.camel@pengutronix.de>
 <CAH-u=810V863yYhMvvtaQ7jxNgrOXAL4bi1mS506a-yOTbuYhQ@mail.gmail.com>
Message-ID: <20160105160421.GX19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 04:40:54PM +0100, Jean-Michel Hautbois wrote:
> Hi Russell,
> 
> 2015-08-27 10:42 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
> >
> > Am Samstag, den 08.08.2015, 17:09 +0100 schrieb Russell King - ARM
> > Linux:
> > > Following on from the previous sub-series, this sub-series adds audio
> > > support to dw-hdmi.
> > >
> > > The two different variants are now in this patch: AHB audio support
> > > found on iMX6 platforms, and I2S support found on Rockchip patches.
> > > Thanks to Yakir Yang for contributing the I2S support.
> > >
> > > I suspect that there is still some discussion to be had on this
> > > series, though I would like to see it moving forward so that we can
> > > get something merged.
> >
> > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > on i.MX6 GK802 via HDMI connected to a TV (stereo only).
> >
> > except for the i2s patch, which is broken in this series.
> >
> > regards
> > Philipp
> 
> 
> What is the status of this series ?
> I would like to use audio output in HDMI on my i.MX6 board, but I
> don't know if you have some pending WIP on this ?

The I2S part has been dropped.  The DesignWare HDMI block is configurable
when it is synthesized - it can contain either the AHB audio interface or
an I2S interface.  Freescale chose to synthesize it with the AHB audio
interface, and this is what my patches are geared up to provide.

On Rockchip devices, they chose to synthesize it with the I2S audio
block, and so they need a different driver for it.  Yakir Yang has been
working on that, but I've not seen anything recently.  After merging
his I2S patch, I found some problems and decided with Yakir that the
best thing to do was to drop it.

So, the result is we support HDMI audio on iMX6.

The changes were merged into mainline during the 4.4 merge window, so
Linux 4.4 will support iMX6 HDMI audio.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
