From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Apr 2014 11:13:37 -0400
Subject: [PATCH v2 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <CAL_JsqLogKfqHyw4zYBkPrYh=f6tVibtmX25oYB1Q2hO11Whcw@mail.gmail.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqLogKfqHyw4zYBkPrYh=f6tVibtmX25oYB1Q2hO11Whcw@mail.gmail.com>
Message-ID: <535535A1.4020501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Monday 21 April 2014 10:37 AM, Rob Herring wrote:
> On Sat, Apr 19, 2014 at 9:32 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Here is an updated version of [2] based on discussion. Series introduces
>> support for setting up dma parameters based on device tree properties
>> like 'dma-ranges' and 'dma-coherent' and also update to ARM 32 bit port.
>> Earlier version of the same series is here [1].
>>
>> The 'dma-ranges' helps to take care of few DMAable system memory restrictions
>> by use of dma_pfn_offset which we maintain now per device. Arch code then
>> uses it for dma address translations for such cases. We update the
>> dma_pfn_offset accordingly during DT the device creation process.The
>> 'dma-coherent' property is used to setup arch's coherent dma_ops.
>>
>> After some off-list discussion with RMK and Arnd, I have now dropped the
>> controversial dma_mask setup code from the series which actually isn't blocking
>> me as such. Considering rest of the parts of the series are already aligned,
>> am hoping to get this version merged for 3.16 merge window.
> 
> Can you briefly describe what the h/w looks like in terms of addresses
> for the problem you are trying to solve? Something like: Cpu view of
> RAM is X to Y address, X corresponds to DMA address Z. Max DMA address
> is ?
> 
Let me try with say 8 GB RAM example

CPU view of memory : 0x0000 0008 0000 0000 to 0x0000 000a 0000 0000

>From above memory range, first 2 GB of memory has an alias 32 bit
view in the hardware. Hardware internally map the address issued within
that first 2 GB to same memory. 

DMA view of first 2 GB [ 0x0000 0008 0000 0000 to 0x0000 0008 7fff ffff]
is : 0x8000 0000 to 0xffff fffff.

Regards,
Santosh 
