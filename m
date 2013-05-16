From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 16 May 2013 13:38:52 +0200
Subject: [RFC/PATCH] dma: of: Make of_dma_simple_xlate match on DMA device
 and channel ID
In-Reply-To: <16693906.m6Wa34B7F1@avalon>
References: <1368624449-29003-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <3106852.EdI2KVGSEm@avalon> <5193A113.4050301@metafoo.de>
 <16693906.m6Wa34B7F1@avalon>
Message-ID: <5194C54C.10300@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 01:30 PM, Laurent Pinchart wrote:
> Hi Lars-Peter,
> 
> On Wednesday 15 May 2013 16:52:03 Lars-Peter Clausen wrote:
>> On 05/15/2013 03:55 PM, Laurent Pinchart wrote:
>>> On Wednesday 15 May 2013 15:39:09 Lars-Peter Clausen wrote:
>>>> On 05/15/2013 03:27 PM, Laurent Pinchart wrote:
>>>>> When translating a DT DMA channel specifier, the most common use case is
>>>>> to match the DMA channel based on the channel DMA engine and channel ID.
>>>>> Modify the of_dma_simple_xlate() function to do so, simplifying the API
>>>>> for DMA engine drivers.
>>>>>
>>>>> There is no need to check the DMA cells count in the filter function as
>>>>> the check is already performed by the caller in of_dma_get_controller().
>>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>
>>>> Hi,
>>>>
>>>> I've submitted a very similar patch some time ago, see
>>>> https://lkml.org/lkml/2013/3/25/250
>>>
>>> Thanks. So my patch makes at least some sense :-)
>>>
>>> I had the impression that this is what omap-dma needs as well, hence the
>>> modification to the existing xlate function. I'm fine with a separate
>>> function as well if the current code covers different use cases.
>>
>> My first attempt was to modify simple_xlate function, but I think it didn't
>> work for all users (some of which aren't applied yet), so I added a separate
>> function.
> 
> OK. Do you plan to push your patch to mainline ? You can add my
> 

Yes, I already submitted it for mainline inclusion. Waiting for Vinod to
either apply or comment on it.

> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
