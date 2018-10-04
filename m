From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Oct 2018 10:45:00 +0100
Subject: [PATCH] asm-generic/pgtable-nop?d.h: define folded with a value
 for use in C
In-Reply-To: <20181003175052.31917-1-james.morse@arm.com>
References: <20181003175052.31917-1-james.morse@arm.com>
Message-ID: <20181004094500.GA108096@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 06:50:52PM +0100, James Morse wrote:
> It turns out "if (__is_defined(__PAGETABLE_PMD_FOLDED))" isn't equivalent
> to "#ifdef __PAGETABLE_PMD_FOLDED". (who knew!)
> 
> kconfig.h's __is_defined() expects a define of the form
> "#define CONFIG_BOOGER 1". But these nop?d headers just have
> "#define __PAGETABLE_PMD_FOLDED".

I wonder why we're using __is_defined() at all on arm64. It looks like
some internal kconfig.h helper for IS_ENABLED() etc. Even if it looks
nicer, I'd rather go for an #ifdef in the arm64 set_pmd() code.

-- 
Catalin
