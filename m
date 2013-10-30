From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Oct 2013 13:46:20 -0700
Subject: [PATCH 1/2] dmaengine: add msm bam dma driver
In-Reply-To: <20131030203105.GA14525@agross>
References: <1382732643-8184-1-git-send-email-agross@codeaurora.org>
 <1382732643-8184-2-git-send-email-agross@codeaurora.org>
 <20131029175603.GF21983@codeaurora.org> <20131030203105.GA14525@agross>
Message-ID: <5271701C.3010706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/13 13:31, Andy Gross wrote:
> On Tue, Oct 29, 2013 at 10:56:03AM -0700, Stephen Boyd wrote:
>> On 10/25, Andy Gross wrote:
>>> +#include <linux/scatterlist.h>
>>> +#include <linux/device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/of_dma.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/msm_bam_dma.h>
>>> +
>>> +#include "dmaengine.h"
>>> +#include "msm_bam_dma_priv.h"
>> Why do we need this file? Can't we just put the #defines in this
>> file?
>  
> There were enough definitions and structures to warrant another file.
>

Ah ok. I find it annoying to flip between two files but I guess that's
my problem.

>>> +	if (!bdev) {
>>> +		dev_err(&pdev->dev, "insufficient memory for private data\n");
>> kmalloc calls already print errors when they fail, so this can be
>> removed.
>  
> has this always been the case?

The warning in the page allocator seems to have been there since pre-git
days (see __alloc_pages_slowpath() and how it calls warn_alloc_failed())
. Other warnings in the sl*b allocators seem to have come later (see
8bdec192b40cf7f7eec170b317c76089eb5eeddb for example).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
