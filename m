From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 24 Jan 2013 14:42:44 +0530
Subject: [PATCH] ARM: DTS: exynos5250-arndale: Add initial board support
 file
In-Reply-To: <CAK9yfHyKK4L_YH5fw=CrcjzeZgfhGKtDMpZQ3GVLnoVt3gkNiQ@mail.gmail.com>
References: <1359008188-23395-1-git-send-email-tushar.behera@linaro.org>
 <CAK9yfHyKK4L_YH5fw=CrcjzeZgfhGKtDMpZQ3GVLnoVt3gkNiQ@mail.gmail.com>
Message-ID: <5100FB0C.7040706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 12:14 PM, Sachin Kamat wrote:
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 5ebb44f..60a9e52 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>>         exynos4210-trats.dtb \
>>         exynos4412-smdk4412.dtb \
>>         exynos5250-smdk5250.dtb \
>> +       exynos5250-arndale.dtb \
> 
> I think this entry could be moved one step up for maintaining
> alphabetical order.
> 

Ok.

>>         exynos5250-snow.dtb \
>>         exynos5440-ssdk5440.dtb
>>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>> new file mode 100644
>> index 0000000..7504cf3
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>> @@ -0,0 +1,124 @@
>> +/*
>> + * Samsung's Exynos5250 based Arndale board device tree source
>> + *
>> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> 
> 2013?
> 

Ok.

>> + *             http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +/include/ "exynos5250.dtsi"
>> +
>> +/ {
>> +       model = "Insignal Arndale evaluation board based on EXYNOS5250";
>> +       compatible = "insignal,arndale", "samsung,exynos5250";
>> +
>> +       memory {
>> +               reg = <0x40000000 0x80000000>;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
> 
> This could be resticted only to console
>                 bootargs = "console=ttySAC2,115200";
> 
> 

Ok.

I will resubmit the patchset.

-- 
Tushar Behera
