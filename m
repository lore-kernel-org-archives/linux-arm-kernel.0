From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 6 Apr 2014 23:27:39 +0100
Subject: [PATCH] arm64: fix !CONFIG_COMPAT build failures
In-Reply-To: <1396707949-397-1-git-send-email-msalter@redhat.com>
References: <1396707949-397-1-git-send-email-msalter@redhat.com>
Message-ID: <20140406222737.GA26274@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 03:25:49PM +0100, Mark Salter wrote:
> Recent arm64 builds using CONFIG_ARM64_64K_PAGES are failing with:
> 
>   arch/arm64/kernel/perf_regs.c: In function ?perf_reg_abi?:
>   arch/arm64/kernel/perf_regs.c:41:2: error: implicit declaration of function ?is_compat_thread?
> 
>   arch/arm64/kernel/perf_event.c:1398:2: error: unknown type name ?compat_uptr_t?
> 
> This is due to some recent arm64 perf commits with compat support:
> 
>   commit 23c7d70d55c6d9:
>     ARM64: perf: add support for frame pointer unwinding in compat mode
> 
>   commit 2ee0d7fd36a3f8:
>     ARM64: perf: add support for perf registers API
> 
> Those patches make the arm64 kernel unbuildable if CONFIG_COMPAT is not
> defined and CONFIG_ARM64_64K_PAGES depends on !CONFIG_COMPAT. This patch
> allows the arm64 kernel to build with and without CONFIG_COMPAT.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Thanks. Applied.

-- 
Catalin
