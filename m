From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 16:57:16 +0100
Subject: [PATCH 2/9] arm64: Fix INVALID_HWID definition
In-Reply-To: <6f84108ac880ef48548208738cbb169fba2fa51a.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <6f84108ac880ef48548208738cbb169fba2fa51a.1408736066.git.geoff@infradead.org>
Message-ID: <20140826155715.GH16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> Change the preprocessor macro INVALID_HWID definition from ULONG_MAX to (~0)
> to allow INVALID_HWID to be used within assembly source files.
> 
> Commit 3e98fdacc59bbbdbb659be1a144ccc48ed4860fa (arm64: kernel: make the pen of
> the secondary a 64-bit unsigned value) added the preprocessor macro INVALID_HWID
> to asm/cputype.h with it defined to be ULONG_MAX.  Use of INVALID_HWID in an
> assembly source file that includes cputype.h will generate an assembler
> undefined symbol ULONG_MAX build error.  The kernel does define a ULONG_MAX in
> kernel.h, but that file not setup to be included in assembly files.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/cputype.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 379d0b8..6b68380 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -16,7 +16,7 @@
>  #ifndef __ASM_CPUTYPE_H
>  #define __ASM_CPUTYPE_H
>  
> -#define INVALID_HWID		ULONG_MAX
> +#define INVALID_HWID		UL(~0)

Does it actually expand to ULONG_MAX? ~0 is an int.

-- 
Catalin
