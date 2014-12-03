From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 3 Dec 2014 06:59:52 +0100
Subject: [PATCH 2/5] ARM: BCM5301X: Add DT for Netgear R6300 V2
In-Reply-To: <547E482C.4060706@hauke-m.de>
References: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
 <1417368513-13808-2-git-send-email-zajec5@gmail.com>
 <547E482C.4060706@hauke-m.de>
Message-ID: <CACna6rwg7+jqiRy9N+RHKJo9EadRzcq-4-8zJziq_Tvko3LYtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 00:15, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 11/30/2014 06:28 PM, Rafa? Mi?ecki wrote:
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                     |  4 +-
>>  arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts | 84 ++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 35f3e12..22bb87f 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -55,7 +55,9 @@ dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
>>  dtb-$(CONFIG_ARCH_AXXIA) += axm5516-amarillo.dtb
>>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
>>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
>> -dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
>> +dtb-$(CONFIG_ARCH_BCM_5301X) += \
>> +     bcm4708-netgear-r6250.dtb \
>> +     bcm4708-netgear-r6300-v2.dtb
>
> This part does not apply cleanly on top of v3.18-rc1.

I think we want these changes to be merged merged into the arm-soc.git
next/dt, right? So I based my changes on that tree. This way Arnd
won't get neither: any conflicts or any unwanted stuff.


>>  dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
>>  dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
>>       bcm911360k.dtb \
>> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
>> new file mode 100644
>> index 0000000..e18b636
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Broadcom BCM470X / BCM5301X ARM platform code.
>> + * DTS for Netgear R6300 V2
>> + *
>> + * Copyright ? 2014 Rafa? Mi?ecki <zajec5@gmail.com>
>
> Is this ? needed here?

Do you mean the whole line or the "?" sign? I think we usually have
"Copyright" lines in files. I can see using "?" is much less common on
the other hand. I think the most common forms are
1) Copyright (C) <year>
2) Copyright <year>
Should I use some of them?
Btw. do you know if this documented anywhere?
