From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Aug 2017 14:51:17 +0100
Subject: [PATCH 1/2] arm64: introduce separated bits for mm_context_t flags
In-Reply-To: <20170805144022.17260-2-ynorov@caviumnetworks.com>
References: <20170805144022.17260-1-ynorov@caviumnetworks.com>
 <20170805144022.17260-2-ynorov@caviumnetworks.com>
Message-ID: <20170808135117.xxcpwonnrnqiqtq6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 05, 2017 at 05:40:21PM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 5468c834b072..2c57b06b2883 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -16,6 +16,8 @@
>  #ifndef __ASM_MMU_H
>  #define __ASM_MMU_H
>  
> +#define MMCF_AARCH32	0x0	/* MM hosts AArch32 executables */

Nitpick: drop 0x since it's a bit number not a flag value. We could,
however, make it a value and just stop using (set|clear)_bit functions.
There is no atomicity issue here.

-- 
Catalin
