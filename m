From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 22 Feb 2012 21:22:04 +0800
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <201202221239.54321.arnd@arndb.de>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
Message-ID: <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 February 2012, Haojian Zhuang wrote:
>> Remove the hardcode definition of rtc registers, use ioremap() instead.
>> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.
>
> What is the status of the drivers/rtc/rtc-pxa.c driver after this series?
> Is is still required for some pxa machines or can it get removed now?
> It seems a little strange to register two platform devices for the
> rtc on each pxa machine, with the same resources.
>
> ? ? ? ?Arnd

Yes, it's very strange to support two RTC wrappers at the same time.
So rtc-pxa is removed in pxa27x/pxa3xx after this patch series. It
only exists in pxa95x.

Thanks
Haojian
