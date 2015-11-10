From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 10 Nov 2015 11:00:59 -0600
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <4982446.ZlJVrezq1Y@wuerfel>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <5349261.sTnZTFhKWB@wuerfel> <56421610.50005@codeaurora.org>
 <4982446.ZlJVrezq1Y@wuerfel>
Message-ID: <564222CB.3000701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2015 10:47 AM, Arnd Bergmann wrote:
> What BenH was worried about here is that the driver sets different masks
> for streaming and coherent mappings, which is indeed a worry that
> could hit us on ARM as well, but I suppose we'll have to deal with
> that in platform code.
>
> Setting both masks to 32-bit is something that a lot of drivers do,
> and without IOMMU enabled, you'd hit the same bug on all of them.

Also note that I think that on PowerPC, the mask is set to 32 by default 
for all devices.  I don't think we do that on ARM64.  So on PowerPC, 
some drivers get away with not explicitly setting the mask.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
