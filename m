From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 14:53:51 +0000
Subject: [PATCH v2 5/6] arm64: audit: Add makefile rule to create
 unistd_32.h for compat syscalls
In-Reply-To: <1389946399-4525-6-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140123145351.GF27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 08:13:18AM +0000, AKASHI Takahiro wrote:
> generic compat sycall audit (lib/compat_audit.c) requires unistd_32.h
> for __NR_xyx compat syscall numbers. This is a different file from unistd32.h
> on arm64 and so it must be generated from unistd32.h.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/Makefile                 |    4 ++++
>  arch/arm64/kernel/syscalls/Makefile |   20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 arch/arm64/kernel/syscalls/Makefile
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2fceb71..6d24f92 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -72,6 +72,10 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
>  
> +# Compat syscall header generation
> +archheaders:
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/syscalls $@

See my other post to the lib/compat_audit.c file. I think that's too
complex for what you need.

-- 
Catalin
