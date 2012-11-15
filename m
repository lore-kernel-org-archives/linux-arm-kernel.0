From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 13:44:29 +0530
Subject: [PATCH] ARM: dts: add board dts file for Exynos4412 based SMDK
 board
In-Reply-To: <0bef01cdbc11$cf1bbd60$6d533820$%kim@samsung.com>
References: <1351954172-13645-1-git-send-email-thomas.abraham@linaro.org>
 <0bef01cdbc11$cf1bbd60$6d533820$%kim@samsung.com>
Message-ID: <CAJuYYwTG+75=NPR-cM-oVZCX7g4PRuX8mZ4-w4=L0YiEuAN_NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2012 16:58, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Add a minimal board dts file for Samsung Exynos4412 based SMDK board.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> This patch depends the on the following patch posted by Tomasz Figa.
>> "ARM: dts: exynos4: Add support for Exynos4x12 SoCs"
>>
>>  arch/arm/boot/dts/Makefile                |    1 +
>>  arch/arm/boot/dts/exynos4412-smdk4412.dts |   45
>> +++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/exynos4412-smdk4412.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index f37cf9f..36488a5 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
>>  dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>>       exynos4210-smdkv310.dtb \
>>       exynos4210-trats.dtb \
>> +     exynos4412-smdk4412.dtb \
>>       exynos5250-smdk5250.dtb
>>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
>>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>> diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts
>> b/arch/arm/boot/dts/exynos4412-smdk4412.dts
>> new file mode 100644
>> index 0000000..f05bf57
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
>> @@ -0,0 +1,45 @@
>> +/*
>> + * Samsung's Exynos4412 based SMDK board device tree source
>> + *
>> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * Device tree source file for Samsung's SMDK4412 board which is based on
>> + * Samsung's Exynos4412 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +/include/ "exynos4412.dtsi"
>> +
>> +/ {
>> +     model = "Samsung SMDK evaluation board based on Exynos4412";
>> +     compatible = "samsung,smdk4412", "samsung,exynos4412";
>> +
>> +     memory {
>> +             reg = <0x40000000 0x40000000>;
>> +     };
>> +
>> +     chosen {
>> +             bootargs ="root=/dev/ram0 rw ramdisk=8192
>> initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
>> +     };
>> +
>> +     serial at 13800000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 13810000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 13820000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 13830000 {
>> +             status = "okay";
>> +     };
>> +};
>> --
>> 1.6.6.rc2
>
> Looks good to me, will apply.
>
> BTW, its default console is ttySAC1 not ttySAC2?

Thanks Mr. Kim. There is support for both ttySAC1 and ttySAC2 as uart
ports. There are corresponding switches on the board that have to be
set. But the default setting is always to use ttySAC1.

Thanks,
Thomas.
