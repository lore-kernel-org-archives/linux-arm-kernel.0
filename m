From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 11 Jun 2013 19:05:38 +0530
Subject: [PATCH 10/13] ARM: dts: Add initial device tree support for
 Exynos5420
In-Reply-To: <20130606163411.GA23311@e106331-lin.cambridge.arm.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <20130606163411.GA23311@e106331-lin.cambridge.arm.com>
Message-ID: <CANuQgHFndqWH5KYskuiqxWuVXEp+_=R=Tnfo5y_syreBFcGPbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2013 22:04, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> new file mode 100644
>> index 0000000..b14e775
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> @@ -0,0 +1,40 @@
>> +/*
>> + * SAMSUNG SMDK5420 board device tree source
>> + *
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +/include/ "exynos5420.dtsi"
>> +
>> +/ {
>> +     model = "Samsung SMDK5420 board based on EXYNOS5420";
>> +     compatible = "samsung,smdk5420", "samsung,exynos5420";
>> +
>> +     memory {
>> +             reg =   <0x20000000 0x10000000
>> +                      0x30000000 0x10000000
>> +                      0x40000000 0x10000000
>> +                      0x50000000 0x10000000
>> +                      0x60000000 0x10000000
>> +                      0x70000000 0x10000000
>> +                      0x80000000 0x10000000
>> +                      0x90000000 0x10000000>;
>> +     };
>
As there are only 28 bits for memory bank size in memory.h.
Hence each bank is split into 256MB.
> This looks a little odd. As these are continguous, you can describe them as one
> bank:
>
>         memory {
>                 reg = <0x20000000 0x80000000>;
>         };
>
> Mark.



--
with warm regards,
Chander Kashyap
