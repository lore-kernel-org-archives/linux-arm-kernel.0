From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Fri, 14 Jul 2017 08:42:35 +0100
Subject: [PATCH v5 1/5] dt-bindings: gpu: add bindings for the ARM Mali
 Midgard GPU
In-Reply-To: <3339c7d9-c420-777c-e8eb-e9b82a38aa97@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <bebe578ba130de5fa320ca7c6427b2fae83d61d7.1493804968.git.guillaume.tucker@collabora.com>
 <20170712172636.GA90759@google.com>
 <3339c7d9-c420-777c-e8eb-e9b82a38aa97@collabora.com>
Message-ID: <cb0f5f26-159a-5c01-da98-572aa4c8d976@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/17 07:41, Guillaume Tucker wrote:
> Hi Brian,
>
> On 12/07/17 18:26, Brian Norris wrote:
>> Hi Guillaume,
>>
>> I know this has already been merged, but I figured here was an OK place
>> to note (inline):
>>
>> On Wed, May 03, 2017 at 10:56:25AM +0100, Guillaume Tucker wrote:
>
> [...]
>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>> new file mode 100644
>>> index 000000000000..d3b6e1a4713a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>>
>> ^^ This file name implies we're talking about a base "arm,mali-midgard"
>> compatible property.
>>
>>> @@ -0,0 +1,86 @@
>>> +ARM Mali Midgard GPU
>>> +====================
>>> +
>>> +Required properties:
>>> +
>>> +- compatible :
>>> +  * Must contain one of the following:
>>> +    + "arm,mali-t604"
>>> +    + "arm,mali-t624"
>>> +    + "arm,mali-t628"
>>> +    + "arm,mali-t720"
>>> +    + "arm,mali-t760"
>>> +    + "arm,mali-t820"
>>> +    + "arm,mali-t830"
>>> +    + "arm,mali-t860"
>>> +    + "arm,mali-t880"
>>> +  * which must be preceded by one of the following vendor specifics:
>>> +    + "amlogic,meson-gxm-mali"
>>> +    + "rockchip,rk3288-mali"
>>
>> But it's not listed here.
>>
>>> +
>>> +- reg : Physical base address of the device and length of the register area.
>>> +
>>> +- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
>>> +
>>> +- interrupt-names : Contains the names of IRQ resources in the order they were
>>> +  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
>>> +
>>> +
>>> +Optional properties:
>>> +
>>> +- clocks : Phandle to clock for the Mali Midgard device.
>>> +
>>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>>> +
>>> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/power/opp.txt
>>> +  for details.
>>> +
>>> +
>>> +Example for a Mali-T760:
>>> +
>>> +gpu at ffa30000 {
>>> +    compatible = "rockchip,rk3288-mali", "arm,mali-t760", "arm,mali-midgard";
>>
>> And it *is* used here in this example.
>>
>> So, should it be used/documented or not?
>
> The important part is that having only arm,mali-midgard in the
> gpu node is not enough to accurately describe the hardware, which
> is why it is not listed in the required compatible strings.  On
> the other hand, it does help with describing the hardware, so
> it's fine to use it.  If people find this confusing then I guess
> we could add something to say that arm,mali-midgard can be used
> optionally in addition to the specific ones.
>
> Also, if you look at the 64-bit ARM CPUs for example, they
> typically have armv8 in their node although armv8 is not
> mentioned anywhere in the bindings documentation...

Sorry I've only just seen Heiko's other emails and patches about
removing arm,mali-midgard from the example.

Guillaume
