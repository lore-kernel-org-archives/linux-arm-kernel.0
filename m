From: oberpar@linux.vnet.ibm.com (Peter Oberparleiter)
Date: Thu, 09 Oct 2014 16:00:20 +0200
Subject: [PATCH] gcov: add ARM64 to GCOV_PROFILE_ALL
In-Reply-To: <1412852099-23099-1-git-send-email-riku.voipio@linaro.org>
References: <1412852099-23099-1-git-send-email-riku.voipio@linaro.org>
Message-ID: <543694F4.3070306@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good. Andrew, can you pick this change up via your tree?

Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

On 09.10.2014 12:54, Riku Voipio wrote:
> Following up the arm testing of gcov, turns out gcov on ARM64
> works fine as well. Only change needed is adding ARM64 to Kconfig
> depends.
> 
> Tested with qemu and mach-virt
> 
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> ---
>  kernel/gcov/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index cf66c5c..3b74087 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -35,7 +35,7 @@ config GCOV_KERNEL
>  config GCOV_PROFILE_ALL
>  	bool "Profile entire Kernel"
>  	depends on GCOV_KERNEL
> -	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
> +	depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM || ARM64
>  	default n
>  	---help---
>  	This options activates profiling for the entire kernel.
> 


-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany
