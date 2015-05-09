From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Sat, 09 May 2015 20:07:45 +0300
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <20150509165536.GS2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk> <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
Message-ID: <554E3EE1.40904@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

09.05.2015, 19:55, Russell King - ARM Linux kirjoitti:
> On Sat, May 09, 2015 at 07:49:44PM +0300, Anssi Hannula wrote:
>> (Of course having userspace set them requires that the device has a
>> proper entry in /usr/share/alsa/cards and the pcm device is accessed via
>> the standard "hdmi" or "iec958" device names which perform the channel
>> status word setup. I guess the ARM SoC stuff generally doesn't bother
>> with that, explaining a bit why some kernel drivers set them by themselves).
> 
> I'm not sure that's sufficient - I haven't yet found where in the ALSA
> userspace, the AES bits are appropriately set according to the sample
> rate.

Right, that is left to the applications (e.g. VLC and Kodi do that). I'm
under the impression that sinks do not normally care about this value,
though, but that could just be because most desktop HW sets it by
themselves.

But indeed, that is one reason to have the kernel set it.

-- 
Anssi Hannula
