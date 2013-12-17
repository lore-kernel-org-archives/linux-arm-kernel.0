From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 12:04:31 +0000
Subject: [PATCH 1/4] arm64: drop redundant macros from read_cpuid()
In-Reply-To: <1387227878-30438-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387227878-30438-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131217120431.GE32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 09:04:35PM +0000, Ard Biesheuvel wrote:
>  #define read_cpuid(reg) ({						\
>  	u64 __val;							\
> -	asm("mrs	%0, " reg : "=r" (__val));			\
> +	asm("mrs	%0, " #reg : "=r" (__val));			\
>  	__val;								\
>  })
>  
> @@ -54,12 +44,12 @@
>   */
>  static inline u32 __attribute_const__ read_cpuid_id(void)
>  {
> -	return read_cpuid(ID_MIDR_EL1);
> +	return read_cpuid(MIDR_EL1);
>  }

It makes sense. Just nitpick, could you please use lowercase register
names for consistency?

Thanks.

-- 
Catalin
