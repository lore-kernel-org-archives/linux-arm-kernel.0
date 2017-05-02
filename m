From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 2 May 2017 12:23:36 +0100
Subject: [PATCH v4 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <20170428192742.pu4v4layszr6z2ot@rob-hp-laptop>
References: <cover.1493125299.git.guillaume.tucker@collabora.com>
 <9349c8ae9091fbd93e9410f4cfae770ac850bf6b.1493125299.git.guillaume.tucker@collabora.com>
 <20170428192742.pu4v4layszr6z2ot@rob-hp-laptop>
Message-ID: <60b3c062-d4bb-6502-61be-ada830cf58f7@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 28/04/17 20:27, Rob Herring wrote:
> On Tue, Apr 25, 2017 at 02:16:16PM +0100, Guillaume Tucker wrote:

>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> new file mode 100644
>> index 000000000000..547ddeceb498
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> @@ -0,0 +1,82 @@
>> +ARM Mali Midgard GPU
>> +====================
>> +
>> +Required properties:
>> +
>> +- compatible :
>> +  * Must be one of the following:
>> +    + "arm,mali-t60x"
>> +    + "arm,mali-t62x"
>
> Don't use wildcards.

Sure, old habits die hard...  I'll fix it in patch v5.

>> +    + "arm,mali-t720"
>> +    + "arm,mali-t760"
>> +    + "arm,mali-t820"
>> +    + "arm,mali-t830"
>> +    + "arm,mali-t860"
>> +    + "arm,mali-t880"
>> +  * And, optionally, one of the vendor specific compatible:
>
> IMO, these should not be optional.

Well, vendor compatible strings are clearly optional for the
Utgard GPU series for which the bindings docs were recently
merged.  It seems that whether these should be optional or not,
the documentation should be consistent between at least all
similar types of devices like Midgard and Utgard GPUs.  They have
different architectures but from a device tree point of view,
they both have the same kind of SoC-specific integration (clocks,
irqs, regulators...).

So was this was overlooked in the Utgard case and should it
ideally be fixed there as well as non-optional?  Or, is it OK to
keep these optional on a second thought?

>> +    + "amlogic,meson-gxm-mali"
>> +    + "rockchip,rk3288-mali"

Guillaume
