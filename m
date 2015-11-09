From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 09:00:31 -0500
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <564046B3.8090505@suse.de>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-2-git-send-email-okaya@codeaurora.org>
 <564046B3.8090505@suse.de>
Message-ID: <5640A6FF.4010703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 2:09 AM, Hannes Reinecke wrote:
> On 11/09/2015 02:57 AM, Sinan Kaya wrote:
>> Current code gives up when 32 bit DMA is not supported.
>> This problem has been observed on systems without any
>> memory below 4 gig.
>>
>> This patch tests 64 bit support before bailing out to find
>> a working combination.
>>
> That feels decidedly odd.
>
> Why do you probe for 64bit if 32bit fails?
> Typically it's the other way round, on the grounds that 64bit DMA
> should be preferred over 32bit.
> Can you explain why it needs to be done the other way round here?
>
> Cheers,
>
> Hannes
>

The platform does not have any memory below 4G. So, 32 bit DMA is not 
possible. I'm trying to use 64 bit DMA instead since both the platform 
and hardware supports it. Current code will not try 64 bit DMA if 32 bit 
DMA is not working.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
