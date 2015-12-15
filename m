From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Dec 2015 20:50:35 +0530
Subject: [PATCH 2/6] ARM: DTS: da850: Use the new DT bindings for the eDMA3
In-Reply-To: <56701E2C.7060308@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
 <1449237210-16381-3-git-send-email-peter.ujfalusi@ti.com>
 <566FDF93.7050005@ti.com> <566FFD1C.4080000@ti.com> <56701A47.9090105@ti.com>
 <56701E2C.7060308@ti.com>
Message-ID: <56702FC3.5050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 07:35 PM, Peter Ujfalusi wrote:
> On 12/15/2015 03:48 PM, Sekhar Nori wrote:

>>>> In future, if/when we gain QDMA support, the QDMA channels could be used
>>>> for memcopy.
>>>
>>> Well, in short there is no way to get the qDMA working in a different way
>>> either. qDMA channel is in essence using 'normal' eDMA channel. This means
>>> that we still need to reserve the eDMA channel to be used for memcpy, but
>>> instead of SW triggering it (as we do it right now), we would need to use the
>>> channel as qDMA and set things up accordingly. I don't really see the benefit
>>> for qDMA mode to be honest.
>>
>> I guess the only advantage is that they will not clash with peripheral
>> mode usage. But even then, some sort of reservation is needed. So I
>> guess QDMA is no better than the EDMA reserved channels?
> 
> It will clash with the peripheral mode use since it needs to take one of the
> eDMA channels. qDMA mode is basically differs from the mode we are using by
> how the channel is triggered. Currently we start the memcpy with SW trigger.

Alright, so I was missing this detail. Thanks for clarifying it on IRC.
The EDMA specification makes it look like 8 additional QDMA channels can
be used over 32 DMA channels, but in reality they are not additional
channels since TCC is only valid between 0-31.

So, I agree. QDMA does not buy us any parallel transfers.

Thanks,
Sekhar
