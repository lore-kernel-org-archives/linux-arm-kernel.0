From: roman@advem.lv (Roman Yeryomin)
Date: Fri, 08 May 2015 00:31:20 +0300
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <alpine.LNX.2.00.1505071935100.19877@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <20150506095312.GU4276@piout.net>
 <d97c3a8a29aa85c83973daf4a22ca4c9@advem.lv> <2349062.9v3Zz7HPLu@wuerfel>
 <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
 <alpine.LNX.2.00.1505071935100.19877@T520.local>
Message-ID: <a16bb259b9275c2da43fdb586da93bc4@advem.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-07 20:35, Hans Ulli Kroll wrote:
> Hi
> 
> On Thu, 7 May 2015, Roman Yeryomin wrote:
> 
>> On 2015-05-06 22:22, Arnd Bergmann wrote:
>> > On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
>> > >
>> > > > Thanks to point that, I'll merge that one which seems clean enough:
>> > > > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
>> > >
>> > > For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital.
>> > > Without that timers are broken and cpu is super slow.
>> >
>> > Do you know what part of the patch is the actual bug fix? We should probably
>> > merge that separately and mark it for stable backports, while the bulk of
>> > that
>> > patch seems to just rearrange code.
>> >
>> >  Arnd
>> 
>> Sorry, didn't try to extract the exact lines it but I guess it's that 
>> part
>> which touches the scheduler clock code.
>> Because without that patch sched clock runs at 100Hz instead of 25MHz.
>> I can dive into this deeper if you want, I just didn't see the need.
>> 
>> Regards,
>> Roman
>> 
>> 
> 
> I've send the RTC driver for Gemini SoC upstream-

I was talking about 160-gemini-timers.patch, not rtc driver.

Regards,
Roman
