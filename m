From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 22 Feb 2012 23:37:27 +0800
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <201202221350.00100.arnd@arndb.de>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
Message-ID: <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 9:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 22 February 2012, Haojian Zhuang wrote:
>> On Wed, Feb 22, 2012 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 21 February 2012, Haojian Zhuang wrote:
>> >> Remove the hardcode definition of rtc registers, use ioremap() instead.
>> >> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.
>> >
>> > What is the status of the drivers/rtc/rtc-pxa.c driver after this series?
>> > Is is still required for some pxa machines or can it get removed now?
>> > It seems a little strange to register two platform devices for the
>> > rtc on each pxa machine, with the same resources.
>>
>> Yes, it's very strange to support two RTC wrappers at the same time.
>> So rtc-pxa is removed in pxa27x/pxa3xx after this patch series. It
>> only exists in pxa95x.
>
> What is the reason for this? Wouldn't it be easier to move pxa95x over
> to use the same driver as well? I guess that can be a series for another
> time, but it seems like you are almost at the point where you can
> remove the other driver entirely.
>
> ? ? ? ?Arnd

I can remove the rtc-pxa support entirely. I still want to leave this
since this may be the only one choice in the future silicons.

Since some boards with pxa27x/pxa3xx are accessing RCNR (the old rtc
wrapper) directly, I use rtc-sa1100 to keep consistently. In pxa95x,
nobody is using the old rtc wrapper directly. So I only use it in
pxa95x.

>From another view, there're more features in new wrapper. It should be
better to overcome the overflow of RTC time.

Best Regards
Haojian
