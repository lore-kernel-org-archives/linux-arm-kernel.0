From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Jun 2013 10:10:51 +0530
Subject: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395@DLEE08.ent.ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
 <1371263570-9323-5-git-send-email-joelagnel@ti.com>
 <3940138.jZFEtfGGLz@wuerfel>
 <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E9395@DLEE08.ent.ti.com>
Message-ID: <51BFE4D3.50509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 6/17/2013 9:10 PM, Fernandes, Joel A wrote:
> Hi Arnd,
> 
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd at arndb.de]
>> Sent: Monday, June 17, 2013 6:13 AM
>> To: Fernandes, Joel A
>> Cc: Tony Lindgren; Nori, Sekhar; Matt Porter; Grant Likely; Rob Herring; Vinod
>> Koul; Mark Brown; Cousson, Benoit; Russell King; Rob Landley; Andrew
>> Morton; Jason Kridner; Koen Kooi; Devicetree Discuss; Linux OMAP List; Linux
>> ARM Kernel List; Linux DaVinci Kernel List; Linux Kernel Mailing List; Linux
>> Documentation List; Linux MMC List; Linux SPI Devel List
>> Subject: Re: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree
>> binding
>>
>> On Friday 14 June 2013 21:32:47 Joel A Fernandes wrote:
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> new file mode 100644
>>> index 0000000..ada0018
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> @@ -0,0 +1,26 @@
>>> +TI EDMA
>>> +
>>> +Required properties:
>>> +- compatible : "ti,edma3"
>>> +- ti,hwmods: Name of the hwmods associated to the EDMA
>>> +- ti,edma-regions: Number of regions
>>> +- ti,edma-slots: Number of slots
>>> +
>>> +Optional properties:
>>> +- ti,edma-xbar-event-map: Crossbar event to channel map
>>
>> You need to list #dma-cells as required here, and which values are accepted
>> by the driver (I suppose only <1>). You should also explain the format of the
>> dma-specifier for a slave here for each possible value of #dma-cells.
>>
>> For each of the standard properties (reg, interrupts, dma-channels), list
>> whether they are optional or required. Since the example has three
>> interrupts, you should probably list how many interrupts need to be specified
>> (minimum and maximum if the number is variable) and in what order to
>> expect them.
>  
> [Joel] Thanks for the suggestion, I updated it and it looks like this now:
>                                                                                                              
> Required properties:                                                                                                                   
> - compatible : "ti,edma3"                                                                                                              
> - ti,hwmods: Name of the hwmods associated to the EDMA  

I have already asked for ti,hwmods to be made optional. Please see my
comment from yesterday.

Thanks,
Sekhar
