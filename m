From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Nov 2017 08:12:03 -0200
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
 <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
Message-ID: <CAOMZO5B_RcXb6X7gUVSJbDpKSHj9eqtDqcYHjEN1n6zhkyCAjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Tue, Nov 14, 2017 at 3:00 AM, Patrick Br?nn <P.Bruenn@beckhoff.com> wrote:
>>From: Fabio Estevam [mailto:festevam at gmail.com]
>>Sent: Montag, 13. November 2017 19:57
>>> I don't recall of any recent change in this area.
>>>
> I don't think the behavior changed recently. I tried a kernel 4.4.65 and it shows the same symptoms. I guess Noel really means 3.19-> 4.0.

Or maybe by 'old kernel' he meant the vendor 2.6.35 kernel.

I have the impression that the dryice driver has never worked in
mainlune for mx53.

> Unfortunately no. Did you run hwclock or rtctest?

Yes, this is what I get:

# hwclock -r -D
hwclock from util-linux 2.31
System Time: 14.876372
Trying to open: /dev/rtc0
Using the rtc interface to the clock.
Last drift adjustment done at 2167 seconds after 1969
Last calibrat[   14.892484] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 08
ion done at 2167 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
hwclock: select() to /dev/rtc0 to wait for clock tick timed out
...synchronization failed


> I still see:
> root at CX9020:~# cat /proc/interrupts | grep rtc
>  40:          0      tzic  24 Edge      53fa4000.srtc
>  41:          0      tzic  25 Edge      53fa4000.srtc
> root at CX9020:~# hwclock -D -r
> hwclock from util-linux 2.29.2
> Using the /dev interface to the clock.
> Last drift adjustment done at 1490885082 seconds after 1969
> Last calibration done at 1490885082 seconds after 1969
> Hardware clock is on UTC time
> Assuming hardware clock is kept in UTC time.
> Waiting for clock tick...
> [   41.035269] irq 40: nobody cared (try booting with the "irqpoll" option)
> [   41.042514] handlers:
> [   41.044847] [<c06031e0>] dryice_irq
> [   41.048398] Disabling IRQ #40

This error I don't get with the 2.31 hwclock version I tried.
