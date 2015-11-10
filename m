From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 10 Nov 2015 15:59:18 -0600
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <4912471.TLsW7CIyYF@wuerfel>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <6333643.g8NiezT8gD@wuerfel> <56425BBF.6000308@codeaurora.org>
 <4912471.TLsW7CIyYF@wuerfel>
Message-ID: <564268B6.9000204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2015 03:54 PM, Arnd Bergmann wrote:

>> In our drivers for 32-bit devices, we have to explicitly set the DMA
>> mask to 32-bits in order to get any DMA working.
>
> Do you mean PCI devices or platform devices?

Platform.

> Maybe the parent bus is lacking a dma-ranges property?

All of this applies only on device-tree platforms.  Sinan and I are 
working on an ACPI server platform.  So we never call 
of_dma_configure(), and we don't have a dma-ranges property.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
