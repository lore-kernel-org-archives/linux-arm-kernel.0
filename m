From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 23:49:54 -0500
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <5640A429.6090302@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
 <563EDA15.7070606@codeaurora.org> <56400909.2090300@codeaurora.org>
 <5640A429.6090302@codeaurora.org>
Message-ID: <56417772.7050905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 8:48 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>>>
>>> And why kmalloc anyway?  Why not leave it on the stack?
>>>
>>>      char src[] = "hello world";
>>>
>>> ?
>>
>> I need to call dma_map_single on this address to convert it to a DMA
>> address. That's why.
>
> And you can't do that with an object that's on the stack?
>

no, pasting from here.

https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt

under 'What memory is DMA'able?'

This rule also means that you may use neither kernel image addresses
(items in data/text/bss segments), nor module image addresses, nor
stack addresses for DMA.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
