From: anssi.hannula@iki.fi (Anssi Hannula)
Date: Sat, 09 May 2015 20:55:10 +0300
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <20150509174054.GT2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk> <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk> <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
Message-ID: <554E49FE.8040004@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

09.05.2015, 20:40, Russell King - ARM Linux kirjoitti:
> On Sat, May 09, 2015 at 08:07:45PM +0300, Anssi Hannula wrote:
>> 09.05.2015, 19:55, Russell King - ARM Linux kirjoitti:
>>> On Sat, May 09, 2015 at 07:49:44PM +0300, Anssi Hannula wrote:
>>>> (Of course having userspace set them requires that the device has a
>>>> proper entry in /usr/share/alsa/cards and the pcm device is accessed via
>>>> the standard "hdmi" or "iec958" device names which perform the channel
>>>> status word setup. I guess the ARM SoC stuff generally doesn't bother
>>>> with that, explaining a bit why some kernel drivers set them by themselves).
>>>
>>> I'm not sure that's sufficient - I haven't yet found where in the ALSA
>>> userspace, the AES bits are appropriately set according to the sample
>>> rate.
>>
>> Right, that is left to the applications (e.g. VLC and Kodi do that). I'm
>> under the impression that sinks do not normally care about this value,
>> though, but that could just be because most desktop HW sets it by
>> themselves.
> 
> No, that seems totally wrong to me.
> 
> What if you open the device using aplay?  Or pulseaudio?  Or madplay?
> Or another audio application which thinks it's addressing a standard
> PCM device.

Then, unless the driver or HW sets it, it is not set.

> Why should every audio user have some code in it to generate the IEC
> bits?

Yeah, it makes zero sense of course, I wasn't claiming otherwise (sorry
if it seemed like it).

> Even VLC _doesn't_ if it's outputting to a standard audio - in other
> words, if you don't tick the SPDIF direct output option which defaults
> to disabled (which, when enabled, opens the device passing the AES
> bits _and_ permits it to send a compressed audio stream.)  I've looked
> at this in VLC many times...

That is my understanding as well. Same for pulseaudio, it doesn't set
any AES bits except for passthrough (and most other applications never
set them).

> I think you're a little confused about what userspace does here.

-- 
Anssi Hannula
