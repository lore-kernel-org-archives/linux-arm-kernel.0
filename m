From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Feb 2017 08:20:40 +0000
Subject: [PATCH v5 5/7] arm: dts: sun8i: split Allwinner H3 .dtsi
In-Reply-To: <CAGb2v67qywz9EdTzguAOEtWYqqrOZ-jSMTgkRza3dysUsCN6rw@mail.gmail.com>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
 <20170226011956.53581-6-icenowy@aosc.xyz>
 <CAGb2v67qywz9EdTzguAOEtWYqqrOZ-jSMTgkRza3dysUsCN6rw@mail.gmail.com>
Message-ID: <579a2e9f-335f-04b7-fce2-ee4d2128141f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/17 03:46, Chen-Yu Tsai wrote:
> Hi,

[...]

>> -               gic: interrupt-controller at 01c81000 {
>> -                       compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
>> -                       reg = <0x01c81000 0x1000>,
>> -                             <0x01c82000 0x2000>,
>> -                             <0x01c84000 0x2000>,
>> -                             <0x01c86000 0x2000>;
>> -                       interrupt-controller;
>> -                       #interrupt-cells = <3>;
>> -                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> 
> The gic bits seem to be the same for both SoCs, aside from the
> different compatible
> string. Marc had sent a series to change them all to arm,gic-400, which is the
> proper name for it, but it wasn't merged. I'm assuming the compatibles
> are equal?
> If so then it can also be shared.

The series was fixing the various GICv2 memory maps, and is now in
mainline. If you have a good indication that all these SoCs are indeed
featuring a gic-400, feel free to amend the DT.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
