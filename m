From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Sep 2017 11:53:55 -0700
Subject: [PATCH] arm64: efi: ignore EFI_MEMORY_XP attribute if RP and/or
 WP are set
In-Reply-To: <20170914193153.18520-1-ard.biesheuvel@linaro.org>
References: <20170914193153.18520-1-ard.biesheuvel@linaro.org>
Message-ID: <20170915185355.GC3349@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14, Ard Biesheuvel wrote:
> The UEFI memory map is a bit vague about how to interpret the
> EFI_MEMORY_XP attribute when it is combined with EFI_MEMORY_RP and/or
> EFI_MEMORY_WP, which have retroactively been redefined as cacheability
> attributes rather than permission attributes.
> 
> So let's ignore EFI_MEMORY_XP if _RP and/or _WP are also set. In this
> case, it is likely that they are being used to describe the capability
> of the region (i.e., whether it has the controls to reconfigure it as
> non-executable) rather than the nature of the contents of the region
> (i.e., whether it contains data that we will never attempt to execute)
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>

Reported-by: Stephen Boyd <sboyd@codeaurora.org>

I will test early next week and provide a tested-by. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
