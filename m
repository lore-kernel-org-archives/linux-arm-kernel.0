From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 29 Apr 2015 09:33:12 -0700
Subject: [PATCH] ARM: proc-feroceon: Fix feroceon_proc_info macro
In-Reply-To: <1430319415-6421-1-git-send-email-andrew@lunn.ch>
References: <20150429140516.GA32151@lunn.ch>
 <1430319415-6421-1-git-send-email-andrew@lunn.ch>
Message-ID: <554107C8.7050701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/15 07:56, Andrew Lunn wrote:
> bf35706f3d09 ("ARM: 8314/1: replace PROCINFO embedded branch with
> relative offset") broke booting for Kirkwood. The kernel would say:
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> Error: unrecognized/unsupported processor variant (0x56251311).
> 
> Fix it by removing the extraneous .long __feroceon_setup from the
> feroceon_proc_info macro.
> 
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks everyone!

> Fixes: bf35706f3d09 ("ARM: 8314/1: replace PROCINFO embedded branch with relative offset")
> ---
>  arch/arm/mm/proc-feroceon.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
> index e494d6d6acbe..92e08bf37aad 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -602,7 +602,6 @@ __\name\()_proc_info:
>  		PMD_SECT_AP_WRITE | \
>  		PMD_SECT_AP_READ
>  	initfn	__feroceon_setup, __\name\()_proc_info
> -	.long __feroceon_setup
>  	.long	cpu_arch_name
>  	.long	cpu_elf_name
>  	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> 


-- 
Florian
