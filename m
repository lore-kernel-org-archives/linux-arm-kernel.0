From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 17:55:36 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <554E3AA8.8060601@iki.fi>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
Message-ID: <20150509165536.GS2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 07:49:44PM +0300, Anssi Hannula wrote:
> (Of course having userspace set them requires that the device has a
> proper entry in /usr/share/alsa/cards and the pcm device is accessed via
> the standard "hdmi" or "iec958" device names which perform the channel
> status word setup. I guess the ARM SoC stuff generally doesn't bother
> with that, explaining a bit why some kernel drivers set them by themselves).

I'm not sure that's sufficient - I haven't yet found where in the ALSA
userspace, the AES bits are appropriately set according to the sample
rate.

> HDMI_FC_AUDICONF2 register default value is 0x00, which means plain
> stereo (per CEA-861). If this is what goes on to the HDMI link as well,
> the audio sink should ignore the other channels.
> Did you check that multichannel PCM actually works? (maybe I'm just
> missing where CA is set)

I have no way to test multichannel support - not everyone has a plethora
of HDMI devices readily accessible.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
