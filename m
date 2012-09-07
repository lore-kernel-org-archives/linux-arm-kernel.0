From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:47:45 +0000
Subject: [PATCH v3 21/31] arm64: 32-bit (compat) applications support
In-Reply-To: <1347035226-18649-22-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-22-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071947.45313.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds support for 32-bit applications. The vectors page is a
> binary blob mapped into the application user space at 0xffff0000 (the
> AArch64 toolchain does not support compilation of AArch32 code). Full
> compatibility with ARMv7 user space is supported. The use of deprecated
> ARMv7 functionality (SWP, CP15 barriers) has been disabled by default on
> AArch64 kernels and unaligned LDM/STM is not supported.
> 
> Please note that only the ARM 32-bit EABI is supported, so no OABI
> compatibility.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

I guess you haven't had time to turn any of these into architecture
independent functions as discussed last time?

	Arnd
