From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Sep 2012 13:53:30 -0400 (EDT)
Subject: [PATCH v3 00/31] AArch64 Linux kernel port
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1209101339270.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Sep 2012, Catalin Marinas wrote:

> This is the 3rd version of patches implementing Linux kernel support for
> the 64-bit ARM architecture. Most of the review comments for the
> previous release have been implemented. There are a few left (like
> generic timer dts specification) but the main goal was to freeze the
> user ABI.
> 
> The Linux kernel patches are available on this tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git upstream
> 
> Main changes since the previous version:
> - ptrace interface now using regsets for TLS and hardware debug
>   registers.
> - sys_personality fixes. PER_LINUX is the default for all tasks (32 or
>   64-bit) and there is no compat_sys_personality defined.
> - Kconfig clean-up (unused symbols, AARCH32_EMULATION removed in favour
>   of COMPAT).
> - Clean-up of the __cpuc_* function prefixes.
> - CPU information table implemented in C rather than assembly.
> - __bad_* function calls replaced with BUILD_BUG.
> - Inline get_user/put_user (code cleaner, slightly bigger kernel Image).
> - DMA API implementation simplified, defaulting to swiotlb. It will be
>   extended as hardware becomes available.
> - Arch-specific code in the generic timer patch moved to arch/arm64/.
> - Comment fixes and clarifications.

For those patches in this series I didn't comment on already:

Acked-by: Nicolas Pitre <nico@linaro.org>

Small nit: please s/nico at cam.org/nico at fluxnic.net/.


Nicolas
