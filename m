From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Jun 2014 15:08:33 -0400
Subject: [PATCH v3 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <4328786.m38YGt2sIU@wuerfel>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <4197388.OE67ahhtqp@wuerfel> <538C9E3C.2000103@ti.com>
 <4328786.m38YGt2sIU@wuerfel>
Message-ID: <538CCBB1.4000209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 03:00 PM, Arnd Bergmann wrote:
> On Monday 02 June 2014 11:54:36 Santosh Shilimkar wrote:
>>
>> On Monday 02 June 2014 11:06 AM, Arnd Bergmann wrote:
>>> On Monday 02 June 2014 09:24:50 Santosh Shilimkar wrote:
>>>> On Monday 02 June 2014 02:37 AM, Shawn Guo wrote:
>>>>> On Thu, Apr 24, 2014 at 11:30:00AM -0400, Santosh Shilimkar wrote:
>>>>>> Here is an updated v3 of the series. Series introduces support for setting up
>>>>>> dma parameters based on device tree properties like 'dma-ranges' and
>>>>>> 'dma-coherent' and also update to ARM 32 bit port. Earlier version of the
>>>>>> series can be found here [3], [2] and [1].
>>>>>
>>>>> Are these two generic device tree properties documented somewhere under
>>>>> Documentation/devicetree/bindings?
>>>>>
>>>> These bindings have been already in use before this series. But looks like
>>>> they have not been documented. I will do a patch to add description for those
>>>> couple of parameters.
>>>
>>> dma-ranges is part of ePAPR, and was documented in some ieee-1275 addenda
>>> before that, but I agree it would be nice to have something in kernel as
>>> well, at the minimum something pointing to the relevant documents.
>>>
>> We are thinking of updating 'Documentation/devicetree/bindings/dma/dma.txt'
>> to add the information for these extra two parameters.
>>
>> Is that fine or any other suggestion ?
> 
> I think that's the wrong place. That entire directory currently deals with
> the specific case of DMA engines, as opposed to the more DMA bus mastering
> in general. We could rename that to
> Documentation/devicetree/bindings/dmaengine, but renames tend to cause
> extra patch conficts, so I'd prefer finding another location for this.
> 
ok.

> How about a section in the top-level
> Documentation/devicetree/booting-without-of.txt file? After all, this
> is very generic and can impact any device that acts as a bus master.
> 
Sounds good. I can add it a section there with heading something like below.

VIII - Specifying dma bus information

Regards,
Santosh
