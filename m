From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Mar 2017 11:26:27 -0500
Subject: [PATCH 1/2] dt-bindings: Document the STM32 MDMA bindings
In-Reply-To: <CAOAejn10dPjYTj8vBTDj5bc_RPTmkYC7uuBMPnP-R0BsQiRwhw@mail.gmail.com>
References: <1489417599-31308-1-git-send-email-cedric.madianga@gmail.com>
 <1489417599-31308-2-git-send-email-cedric.madianga@gmail.com>
 <20170320215250.wwhq6lzwe45jmwks@rob-hp-laptop>
 <CAOAejn10dPjYTj8vBTDj5bc_RPTmkYC7uuBMPnP-R0BsQiRwhw@mail.gmail.com>
Message-ID: <CAL_JsqLMn7W=r+JRX51zOScs9N04PcTtX8EFy2eacwadCxwaRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 5:06 AM, M'boumba Cedric Madianga
<cedric.madianga@gmail.com> wrote:
> Hi Rob,
>
> 2017-03-20 22:52 GMT+01:00 Rob Herring <robh@kernel.org>:
>> On Mon, Mar 13, 2017 at 04:06:38PM +0100, M'boumba Cedric Madianga wrote:
>>> This patch adds documentation of device tree bindings for the STM32 MDMA
>>> controller.
>>>
>>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>> Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
>>> ---
>>>  .../devicetree/bindings/dma/stm32-mdma.txt         | 94 ++++++++++++++++++++++
>>>  1 file changed, 94 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
>>> new file mode 100644
>>> index 0000000..26a930c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
>>> @@ -0,0 +1,94 @@
>>> +* STMicroelectronics STM32 MDMA controller
>>> +
>>> +The STM32 MDMA is a general-purpose direct memory access controller capable of
>>> +supporting 64 independent DMA channels with 256 HW requests.
>>> +
>>> +Required properties:
>>> +- compatible: Should be "st,stm32-mdma"
>>
>> Should be more specific.
>
> The compatible string is not specific enough ? I don't see how to specific more.

stm32 is not a specific SoC. Compatible strings should be specific to
an SoC (with fallback strings to whatever they are compatible with) so
you can handle SoC specific differences or errata.

>>> +- reg: Should contain MDMA registers location and length. This should include
>>> +  all of the per-channel registers.
>>> +- interrupts: Should contain the MDMA interrupt.
>>> +- clocks: Should contain the input clock of the DMA instance.
>>> +- resets: Reference to a reset controller asserting the DMA controller.
>>> +- #dma-cells : Must be <5>. See DMA client paragraph for more details.
>>> +
>>> +Optional properties:
>>> +- dma-channels: Number of DMA channels supported by the controller.
>>> +- dma-requests: Number of DMA request signals supported by the controller.
>>> +- st,ahb-addr-masks: Array of u32 mask to list memory devices addressed via
>>> +  AHB bus.
>>
>> I don't understand what this is.
>
> The MDMA is able to address memories and devices from AHB bus or AXI bus.
> The MDMA has a little different way of working to address AHB
> device/memory and AXI device/memory.
> In STM32H7 platform, almost all devices are addressed by AXI bus.
> But we have some memories adress by AHB bus.
> So, we add these parameter to be able to handle this.

I still don't understand. Is the difference in DMA addresses vs. CPU
addresses? If so, you should dma-ranges to translate these.

Rob
