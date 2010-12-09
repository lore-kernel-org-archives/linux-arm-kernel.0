From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 9 Dec 2010 15:28:42 +0800
Subject: [PATCH 1/6] ARM: mx5: use config to define boot related addresses
In-Reply-To: <20101209070411.GH17441@pengutronix.de>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<20101209070411.GH17441@pengutronix.de>
Message-ID: <AANLkTikfenirotizODPEDj0Qg7X5wu5k_-18LWpLRQgJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Dec 09, 2010 at 10:08:31PM +0800, Richard Zhao wrote:
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> ---
>> This series of patch support mx50 reference design board. I've tested it using
>> initramfs on the board.
>>
>> ?arch/arm/mach-mx5/Makefile.boot | ? ?6 +++---
>> ?1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
>> index 9939a19..388d2e8 100644
>> --- a/arch/arm/mach-mx5/Makefile.boot
>> +++ b/arch/arm/mach-mx5/Makefile.boot
>> @@ -1,3 +1,3 @@
>> - ? zreladdr-y ? ? ? ?:= 0x90008000
>> -params_phys-y ? ? ? ?:= 0x90000100
>> -initrd_phys-y ? ? ? ?:= 0x90800000
>> + ? zreladdr-$(CONFIG_SOC_IMX51) ? ? ?:= 0x90008000
>> +params_phys-$(CONFIG_SOC_IMX51) ? ? ?:= 0x90000100
>> +initrd_phys-$(CONFIG_SOC_IMX51) ? ? ?:= 0x90800000
> That is one of the places that is not multi-soc capable. ?You can make
> it 66% less worse by just removing params_phys and initrd_phys.
Yes. Thanks!

Richard
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Uwe Kleine-K?nig ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
