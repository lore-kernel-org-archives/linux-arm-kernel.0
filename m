From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 12:06:07 +0200
Subject: [PATCH v10 1/3] arm64: Add __NR_* definitions for compat syscalls
In-Reply-To: <1404458911-8214-2-git-send-email-takahiro.akashi@linaro.org>
References: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
 <1404458911-8214-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <5418828.mxvNk2rT0e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 16:28:29 AKASHI Takahiro wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch adds __NR_* definitions to asm/unistd32.h, moves the
> __NR_compat_* definitions to asm/unistd.h and removes all the explicit
> unistd32.h includes apart from the one building the compat syscall
> table. The aim is to have the compat __NR_* definitions available but
> without colliding with the native syscall definitions.
> 
> And adds more syscall definitions for 3.16.

Can you explain in more detail why you want to add those macros? I've
looked at all three patches in the series but can't find any code using
them.

I would expect that we don't need to define those macros at all for
compat mode, since they are meant primarily for user space (glibc)
compilation, which gets them from arch/arm/include/asm/unistd.h.

	Arnd
