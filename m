From: ibanezchen@gmail.com (Howard Chen)
Date: Fri, 14 Nov 2014 13:03:17 +0800
Subject: [PATCH v6 1/4] ARM: mediatek: Add basic support for mt6592
In-Reply-To: <CABuKBeJv0S2Q4W1fqb=8BUG6AEvFsZ6sY9QXuz=CRe+qbaYzQQ@mail.gmail.com>
References: <1415808457-4030-1-git-send-email-ibanezchen@gmail.com>
 <CABuKBeJv0S2Q4W1fqb=8BUG6AEvFsZ6sY9QXuz=CRe+qbaYzQQ@mail.gmail.com>
Message-ID: <CAHwZioFS==fkVKUEa7Qs6NUm6Q-N9npBFz-nj-s_mDiW6mcSkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 12:17 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> 2014-11-12 17:07 GMT+01:00 Howard Chen <ibanezchen@gmail.com>:
>> * A dtsi for boards based on Mediatek MT6592 SoCs
>> * Compatible string in arch/arm/mach-mediatek/mediatek.c
>>
>> Signed-off-by: Howard Chen <ibanezchen@gmail.com>
>> ---
>>  arch/arm/boot/dts/mt6592.dtsi     | 97 +++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-mediatek/mediatek.c |  1 +
>>  2 files changed, 98 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/mt6592.dtsi
>>
>> diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
>> new file mode 100644
>> index 0000000..65aa81b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/mt6592.dtsi
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Copyright (c) 2014 MediaTek Inc.
>> + * Author: Howard Chen <ibanezchen@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include "skeleton.dtsi"
>
> Regarding a discussion I had with Joe and Arnd [0], I think we should
> use skeleton64.dtsi here, right?
> The datasheets states that mt6592 supports up to 8 GB.
>
> [0] https://lkml.org/lkml/2014/11/4/192


  No, the maximum addressing capacity of mt6592 is 2G bytes.
