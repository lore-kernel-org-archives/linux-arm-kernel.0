From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 18:40:54 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <554E3EE1.40904@iki.fi>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
Message-ID: <20150509174054.GT2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 08:07:45PM +0300, Anssi Hannula wrote:
> 09.05.2015, 19:55, Russell King - ARM Linux kirjoitti:
> > On Sat, May 09, 2015 at 07:49:44PM +0300, Anssi Hannula wrote:
> >> (Of course having userspace set them requires that the device has a
> >> proper entry in /usr/share/alsa/cards and the pcm device is accessed via
> >> the standard "hdmi" or "iec958" device names which perform the channel
> >> status word setup. I guess the ARM SoC stuff generally doesn't bother
> >> with that, explaining a bit why some kernel drivers set them by themselves).
> > 
> > I'm not sure that's sufficient - I haven't yet found where in the ALSA
> > userspace, the AES bits are appropriately set according to the sample
> > rate.
> 
> Right, that is left to the applications (e.g. VLC and Kodi do that). I'm
> under the impression that sinks do not normally care about this value,
> though, but that could just be because most desktop HW sets it by
> themselves.

No, that seems totally wrong to me.

What if you open the device using aplay?  Or pulseaudio?  Or madplay?
Or another audio application which thinks it's addressing a standard
PCM device.

Why should every audio user have some code in it to generate the IEC
bits?

Even VLC _doesn't_ if it's outputting to a standard audio - in other
words, if you don't tick the SPDIF direct output option which defaults
to disabled (which, when enabled, opens the device passing the AES
bits _and_ permits it to send a compressed audio stream.)  I've looked
at this in VLC many times...

I think you're a little confused about what userspace does here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
