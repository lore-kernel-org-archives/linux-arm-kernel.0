From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 May 2015 18:08:16 +0200
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2349062.9v3Zz7HPLu@wuerfel> <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
Message-ID: <2131951.l0j0CIttAZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 12:03:25 Roman Yeryomin wrote:
> On 2015-05-06 22:22, Arnd Bergmann wrote:
> > On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
> >> 
> >> > Thanks to point that, I'll merge that one which seems clean enough:
> >> > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
> >> 
> >> For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital.
> >> Without that timers are broken and cpu is super slow.
> > 
> > Do you know what part of the patch is the actual bug fix? We should 
> > probably
> > merge that separately and mark it for stable backports, while the bulk 
> > of that
> > patch seems to just rearrange code.
> > 
> >       Arnd
> 
> Sorry, didn't try to extract the exact lines it but I guess it's that 
> part which touches the scheduler clock code.
> Because without that patch sched clock runs at 100Hz instead of 25MHz.
> I can dive into this deeper if you want, I just didn't see the need.

I think that would be helpful, yes.

	Arnd
