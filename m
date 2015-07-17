From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 12:08:01 +0100
Subject: [PATCH 4/5] arm64: kernel: Add optional CONFIG_ parameter to
 ALTERNATIVE().
In-Reply-To: <1437062519-18883-5-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-5-git-send-email-james.morse@arm.com>
Message-ID: <20150717110800.GE13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:01:58PM +0100, James Morse wrote:
> Some uses of ALTERNATIVE() may depend on a feature that is disabled at
> compile time by a Kconfig option. In this case the unused alternative
> instructions waste space, and if the original instruction is a nop, it
> wastes time and space.
> 
> This patch adds an optional 'config' option to ALTERNATIVE() and
> alternative_insn that allows the compiler to remove both the original
> and alternative instructions if the config option is not defined.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
