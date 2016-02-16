From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 18:22:35 +0000
Subject: [PATCH] arm64: vdso: Mark vDSO code as read-only
In-Reply-To: <1455141142-6838-1-git-send-email-david.brown@linaro.org>
References: <1455141142-6838-1-git-send-email-david.brown@linaro.org>
Message-ID: <20160216182235.GE19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 01:52:22PM -0800, David Brown wrote:
> diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso/vdso.S
> index 60c1db5..db7c0f2 100644
> --- a/arch/arm64/kernel/vdso/vdso.S
> +++ b/arch/arm64/kernel/vdso/vdso.S
> @@ -24,6 +24,7 @@
>  	__PAGE_ALIGNED_DATA
>  
>  	.globl vdso_start, vdso_end
> +	.section .rodata
>  	.balign PAGE_SIZE
>  vdso_start:
>  	.incbin "arch/arm64/kernel/vdso/vdso.so"
> -- 
> 2.7.1

Patch applied (and removed __PAGE_ALIGNED_DATA as well). Thanks.

-- 
Catalin
