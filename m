From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 27 Jun 2017 08:09:35 +0000
Subject: [PATCH v2 3/5] dt-bindings: stm32-dma: Add property to handle
 STM32 DMAMUX
In-Reply-To: <20170626193331.5jle4oxgvqmsvs5b@rob-hp-laptop>
References: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
 <1498222853-11110-4-git-send-email-pierre-yves.mordret@st.com>
 <20170626193331.5jle4oxgvqmsvs5b@rob-hp-laptop>
Message-ID: <b573370a-13d3-e5cc-781a-0f05a6767f7c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/26/2017 09:33 PM, Rob Herring wrote:
> On Fri, Jun 23, 2017 at 03:00:51PM +0200, Pierre-Yves MORDRET wrote:
>> This patch adds an optional property needed for STM32 DMA controller
>> addressed via STM32 DMAMUX.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>      v2:
>>          * Typo fix
>> ---
>> ---
>>   Documentation/devicetree/bindings/dma/stm32-dma.txt | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> index 4408af6..340c918 100644
>> --- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
>> @@ -16,6 +16,9 @@ Optional properties:
>>   - resets: Reference to a reset controller asserting the DMA controller
>>   - st,mem2mem: boolean; if defined, it indicates that the controller supports
>>     memory-to-memory transfer
>> +- st,dmamux: boolean; if defined, it indicates that the controller is behind a
>> +  DMA multiplexer. In that case, using dma instances doesn't work for DMA
>> +  clients. They have to use dma-router instances.
> 
> Won't this be obvious looking at the bindings for clients?
> 
> In any case, this should be implied by the compatible string.
> 
> Rob
> 

Not sure what you are asking here.

Py
