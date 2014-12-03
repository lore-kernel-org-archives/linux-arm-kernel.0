From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Wed, 3 Dec 2014 17:16:52 +0800
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20141127115042.GE857@leverpostej>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141127115042.GE857@leverpostej>
Message-ID: <CAAfSe-tf8WMRPnPZuEsDYbjMjBHnkSud_aX4ksu6yvnEDD-SAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> +       gic: interrupt-controller at 12001000 {
>> +               compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>> +               #interrupt-cells = <3>;
>> +               interrupt-controller;
>> +               reg = <0 0x12001000 0 0x1000>,
>> +                     <0 0x12002000 0 0x1000>,
>> +                     <0 0x12004000 0 0x2000>,
>> +                     <0 0x12006000 0 0x2000>;
>> +       };
>
> I believe GICC should be 8KiB here.
>
Yes, I'll correct it in next patch.
>> +
>> +       psci {
>> +               compatible = "arm,psci-0.2";
>> +               method = "smc";
>> +       };
>
> Do you have a complete PSCI 0.2 implementation (e.g. are all the
> mandatory functions implemented)?
>
I was using the latest boot-wrapper as the bootloader for test,  I'll
add a compatible string "arm,psci" in v4.
We'll use u-boot on real hardware, the support for PSCI in our u-boot
is in progress.
We're intending to implement psci-0.1 at first, and psci-0.2 for the next step.

> I take it CPUs enter the kernel at EL2?
>
yes, we've just do like this.

> How have you tested this?

I'll test it on the SC9836 FPGA board before next submitting.

Thanks for your patient review.
Chunyan
