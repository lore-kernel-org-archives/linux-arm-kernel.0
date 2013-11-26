From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Nov 2013 19:32:47 +0000
Subject: KNOT / CONTINUOUS (was: [PATCH] ASoC: kirkwood: Fix invalid
 SPDIF format)
In-Reply-To: <20131126200916.47a45929@armhf>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf>
Message-ID: <20131126193246.GH16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 08:09:16PM +0100, Jean-Francois Moine wrote:
> Otherwise, removing SNDRV_PCM_RATE_CONTINUOUS in the codec, I can hear
> the 7850Hz stream which is converted to 22.05 kHz by vlc, but when I
> want a stream at 33.075kHz, vlc converts it to 32kHz.

What is your fascination with doing stuff outside the specifications?
The HDMI spec is quite clear:

"An HDMI Source is permitted to transmit L-PCM audio data at sample rates
of 32kHz, 44.1kHz, 48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz."

It goes on to say:

"An HDMI Sink may accept L-PCM audio at sample rates of 32kHz, 44.1kHz,
48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz, and should indicate these
capabilities in the E-EDID data structure."

That doesn't say that 8kHz, 22.05kHz etc are valid sample rates for
HDMI.  It may work for some devices but it's non-standard.
