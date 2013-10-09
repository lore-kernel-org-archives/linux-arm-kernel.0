From: lbassel@codeaurora.org (Larry Bassel)
Date: Wed, 9 Oct 2013 09:47:26 -0700
Subject: [RFC PATCH 1/5] arm: mm: add CONFIG_STRICT_MEMORY_RWX
In-Reply-To: <1381282292-25251-2-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
 <1381282292-25251-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131009164726.GA379@labbmf01-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08 Oct 13 18:31, Laura Abbott wrote:
> From: Larry Bassel <lbassel@codeaurora.org>
> 
> If this is set, kernel text will be made RX, kernel data and stack
> RW, rodata R so that writing to kernel text, executing kernel data
> or stack, or writing to read-only data or kernel text will not
> succeed.
> 
> Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm/mm/Kconfig |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index cd2c88e..c223d5c 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -952,3 +952,15 @@ config ARCH_HAS_BARRIERS
>  	help
>  	  This option allows the use of custom mandatory barriers
>  	  included via the mach/barriers.h file.
> +
> +config STRICT_MEMORY_RWX
> +	bool "restrict kernel memory permissions as much as possible"
> +	default n
> +	help
> +	  If this is set, kernel text will be made RX, kernel data and stack
> +	  RW, rodata R (otherwise all of the kernel 1-to-1 mapping is
> +	  made RWX).
> +	  The tradeoff is that several sections are padded to
> +	  1M boundaries (because their permissions are different and

As this presumably (if it is accepted) will also need to run on
LPAE systems, we should say section not 1M here and below.

> +	  splitting the 1M pages into 4K ones causes TLB performance
> +	  problems), wasting memory.
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 

Larry

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
