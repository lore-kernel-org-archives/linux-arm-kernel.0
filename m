From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Thu, 20 Apr 2017 06:58:46 +0100
Subject: [PATCH v3 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <5481965.3RkcDb038R@phil>
References: <cover.1492588180.git.guillaume.tucker@collabora.com>
 <96021d989387d9aaff039efebd66aa3bfe667941.1492588180.git.guillaume.tucker@collabora.com>
 <5481965.3RkcDb038R@phil>
Message-ID: <4fd957ab-8365-eb4f-b003-467d3747a949@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 19/04/17 10:02, Heiko Stuebner wrote:
> Am Mittwoch, 19. April 2017, 09:06:17 CEST schrieb Guillaume Tucker:
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> new file mode 100644
>> index 000000000000..917c4f8d178f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> @@ -0,0 +1,57 @@
>> +ARM Mali Midgard GPU
>> +====================
>> +
>> +Required properties:
>> +
>> +- compatible :
>> +  * Must be one of the following:
>> +    + "arm,mali-t60x"
>> +    + "arm,mali-t62x"
>> +    + "arm,mali-t720"
>> +    + "arm,mali-t760"
>> +    + "arm,mali-t820"
>> +    + "arm,mali-t830"
>> +    + "arm,mali-t860"
>> +    + "arm,mali-t880"
>> +  * And, optionally, one of the vendor specific compatible:
>> +    + "amlogic,meson-gxm-mali"
>
> Please add a "rockchip,rk3288-mali" as well :-) , as I don't trust that the
> generic compatible will be enough for all time and having that already
> defined makes fixing the per soc things later a lot easier.

Sure, will do in patch v4.

>> +
>> +- reg : Physical base address of the device and length of the register area.
>> +
>> +- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
>> +
>> +- interrupt-names : Contains the names of IRQ resources in the order they were
>> +  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
>> +
>> +
>> +Optional properties:
>> +
>> +- clocks : Phandle to clock for the Mali Midgard device.
>> +
>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>> +
>> +- operating-points : Refer to Documentation/devicetree/bindings/power/opp.txt
>> +  for details.

So I can simply change that to operating-points-v2.  Both
versions can be used in practice but it sounds like
operating-points can just be ignored in this binding's
documentation.  Could you please confirm?

Thanks,
Guillaume
