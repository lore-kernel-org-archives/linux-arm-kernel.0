From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 Mar 2015 11:43:17 +0200
Subject: [PATCH 0/3] Improve dw-hdmi CTS/N setting
In-Reply-To: <20150327111320.GA4019@n2100.arm.linux.org.uk>
References: <20150327111320.GA4019@n2100.arm.linux.org.uk>
Message-ID: <1427708597.3739.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Freitag, den 27.03.2015, 11:13 +0000 schrieb Russell King - ARM
Linux:
> All,
> 
> This is a mini-series to try and move audio support for the Designware
> HDMI bridge along.
>
> There are two known versions of the Designware HDMI audio:
> 
> - The Rockchip version, which is based upon feeding the HDMI block I2S
>   stream(s), which doesn't have any on-board DMA support.
> - The Freescale version, which only has AHB DMA support.
> 
> There are two drivers around at present, one which I've had which is
> ALSA based due to its simplicity for the Freescale version of the IP,
> and one which is ASoC based from Yakir Yang for the Rockchip version.
> 
> There is some commonality between the two drivers - for example, the
> setup of the CTS/N values is very similar, although not identical.
> 
> I have been reviewing (when time permits) the patches from Yakir Yang,
> and making recommendations to try and extract the common parts of the
> driver.  This is the patch set I came up with (mentioned in
> 20150202130920.GC8656 at n2100.arm.linux.org.uk).
> 
> Yakir merged some of my ideas into his patch set - for example, Yakir
> Yang's "drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and
> hdmi_regenerate_cts()" is very close to the version which I came up
> with.
> 
> Yakir Yang didn't include the mutex patch, which I've included here -
> it really is necessary because we have potentially two different
> threads which can change the CTS/N values - a change of the video mode
> vs a change in the audio driver.
> 
> The last patch is adjusting the CTS/N setting order - I have only gone
> as far as what we know works for iMX6, and this is also identical to
> Yakir Yang's patch.
> 
> The identical nature is hardly surprising; my patches were derived from
> a previous set of his patches (which I acknowledge in the commit messages)
> and I detailed in the above message what I wanted to see.
> 
> What I would like to see is that - as we are effectively in agreement
> over two of these patches - we get these patches merged rather than
> having to repeatedly see them.  If there's any objection, please let me
> know, otherwise I'll collect acks and send them to David.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Also,
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
(with your dw-hdmi-audio patches on i.MX6)

best regards
Philipp
