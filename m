From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 14 Oct 2015 10:40:56 -0500
Subject: [PATCHv3 10/11] arm64: Add 16K page size support
In-Reply-To: <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <561E7788.6080900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 06:20 AM, Suzuki K. Poulose wrote:
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index da32354..736ed4c 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -24,6 +24,9 @@
>   #ifdef CONFIG_ARM64_64K_PAGES
>   #define PAGE_SHIFT		16
>   #define CONT_SHIFT		5
> +#elif defined(CONFIG_ARM64_16K_PAGES)
> +#define PAGE_SHIFT		14
> +#define CONT_SHIFT		9
>   #else
>   #define PAGE_SHIFT		12
>   #define CONT_SHIFT		4

Suzuki,

Is CONT_SHIFT correct? I thought it should be 7? The ARM-ARM says that a 
contiguous 3rd level lookup is 128 entries.

Thanks,
	Jeremy
