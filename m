From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 21 Apr 2015 15:47:25 -0500
Subject: [PATCH v4 05/11] ARM: dts: add imx7d soc dtsi file
In-Reply-To: <CAL_JsqLP6ZE9_G1L9XzT-hR=k6Wzx80rKQMTdagp8q80ADN61g@mail.gmail.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
 <1429563933-3129-6-git-send-email-Frank.Li@freescale.com>
 <CAL_JsqLP6ZE9_G1L9XzT-hR=k6Wzx80rKQMTdagp8q80ADN61g@mail.gmail.com>
Message-ID: <CAHrpEqSGuFu-+M39zqiOcpsjS9UOxvoy2tRHHmZFwBdftpiqjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 3:37 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, Apr 20, 2015 at 4:05 PM,  <Frank.Li@freescale.com> wrote:
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> Add i.mx7d support:
>>         imx7d dtsi part
>>
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi | 498 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 498 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx7d.dtsi
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> new file mode 100644
>> index 0000000..dd391e2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -0,0 +1,498 @@
>> +/*
>> + * Copyright 2015 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>
> You should dual license dts files with BSD or MIT for any non-Linux users.

Do you have sample BSD/GPL dual license header?

>
>
>> +
>> +       timer {
>> +               compatible = "arm,armv7-timer";
>> +               arm,cpu-registers-not-fw-configured;
>
> Fix your bootloader. This is for broken bootloaders which can't be fixed.
>
>> +               interrupts = <GIC_PPI 13
>> +                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +                       <GIC_PPI 14
>> +                       (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +               interrupt-parent = <&intc>;
>> +               clock-frequency = <8000000>;
>
> Ditto.

Okay I remove timer part totally for this patch series.

>
> Rob
