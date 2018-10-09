From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 9 Oct 2018 10:17:39 +0200
Subject: [PATCH v3 3/7] dt-bindings: stm32-mdma: Add DMA/MDMA chaining
 support bindings
In-Reply-To: <20181007145930.GA2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-4-git-send-email-pierre-yves.mordret@st.com>
 <20181007145930.GA2372@vkoul-mobl>
Message-ID: <31f5a087-6a83-76ff-dc5c-29e8ecc95744@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/2018 04:59 PM, Vinod wrote:
> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>>
>> This patch adds the description of the 2 properties needed to support M2M
>> transfer triggered by STM32 DMA when his transfer is complete.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v3:
>>     v2:
>>        * rework content
>>     v1:
>>        * Initial
>> ---
>> ---
>>  Documentation/devicetree/bindings/dma/stm32-mdma.txt | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
>> index d18772d..27c2812 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
>> +++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
>> @@ -10,7 +10,7 @@ Required properties:
>>  - interrupts: Should contain the MDMA interrupt.
>>  - clocks: Should contain the input clock of the DMA instance.
>>  - resets: Reference to a reset controller asserting the DMA controller.
>> -- #dma-cells : Must be <5>. See DMA client paragraph for more details.
>> +- #dma-cells : Must be <6>. See DMA client paragraph for more details.
> 
> can you update the example for 6 cells?

of course.

> 
> Also what happens to dts using 5 cells..

They are not managed, but it should. I will update this flaw. Thanks for
pointing this out.

> 
>>  
>>  Optional properties:
>>  - dma-channels: Number of DMA channels supported by the controller.
>> @@ -26,7 +26,7 @@ Example:
>>  		interrupts = <122>;
>>  		clocks = <&timer_clk>;
>>  		resets = <&rcc 992>;
>> -		#dma-cells = <5>;
>> +		#dma-cells = <6>;
>>  		dma-channels = <16>;
>>  		dma-requests = <32>;
>>  		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
>> @@ -35,8 +35,8 @@ Example:
>>  * DMA client
>>  
>>  DMA clients connected to the STM32 MDMA controller must use the format
>> -described in the dma.txt file, using a five-cell specifier for each channel:
>> -a phandle to the MDMA controller plus the following five integer cells:
>> +described in the dma.txt file, using a six-cell specifier for each channel:
>> +a phandle to the MDMA controller plus the following six integer cells:
>>  
>>  1. The request line number
>>  2. The priority level
>> @@ -76,6 +76,10 @@ a phandle to the MDMA controller plus the following five integer cells:
>>     if no HW ack signal is used by the MDMA client
>>  5. A 32bit mask specifying the value to be written to acknowledge the request
>>     if no HW ack signal is used by the MDMA client
>> +6. A bitfield value specifying if the MDMA client wants to generate M2M
>> +   transfer with HW trigger (1) or not (0). This bitfield should be only
>> +   enabled for M2M transfer triggered by STM32 DMA client. The memory devices
>> +   involved in this kind of transfer are SRAM and DDR.
>>  
>>  Example:
>>  
>> -- 
>> 2.7.4
> 
