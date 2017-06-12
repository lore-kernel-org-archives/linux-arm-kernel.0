From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 12 Jun 2017 13:36:20 -0700
Subject: [PATCH] arm64/dma-mapping: Fix null-pointer check
In-Reply-To: <20170610220354.GY4902@n2100.armlinux.org.uk>
References: <20170610194110.27712-1-ohaugan@codeaurora.org>
 <20170610220354.GY4902@n2100.armlinux.org.uk>
Message-ID: <20170612203620.yrdb3pnrm6xt6nub@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-06-10 23:03:54, Russell King - ARM Linux wrote:
> On Sat, Jun 10, 2017 at 12:41:10PM -0700, Olav Haugan wrote:
> > @@ -149,6 +140,11 @@ static void *__dma_alloc(struct device *dev, size_t size,
> >  	bool coherent = is_device_dma_coherent(dev);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This re-introduces an instance that you say you're getting rid of...
> 

The ARM64 version of is_device_dma_coherent() checks for !dev
already...But anyway I will completely remove the !dev checks in the
alloc/free functions since as Catalin pointed out it is coverted
elsewhere.

-- 
.Olav

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
