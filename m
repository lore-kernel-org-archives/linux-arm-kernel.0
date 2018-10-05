From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Oct 2018 12:02:37 +0100
Subject: [PATCH] asm-generic/pgtable-nop?d.h: define folded with a value
 for use in C
In-Reply-To: <20181004094500.GA108096@arrakis.emea.arm.com>
References: <20181003175052.31917-1-james.morse@arm.com>
 <20181004094500.GA108096@arrakis.emea.arm.com>
Message-ID: <20181005110237.ygozdfgfifwglu5x@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 10:45:00AM +0100, Catalin Marinas wrote:
> On Wed, Oct 03, 2018 at 06:50:52PM +0100, James Morse wrote:
> > It turns out "if (__is_defined(__PAGETABLE_PMD_FOLDED))" isn't equivalent
> > to "#ifdef __PAGETABLE_PMD_FOLDED". (who knew!)
> > 
> > kconfig.h's __is_defined() expects a define of the form
> > "#define CONFIG_BOOGER 1". But these nop?d headers just have
> > "#define __PAGETABLE_PMD_FOLDED".
> 
> I wonder why we're using __is_defined() at all on arm64. It looks like
> some internal kconfig.h helper for IS_ENABLED() etc. Even if it looks
> nicer, I'd rather go for an #ifdef in the arm64 set_pmd() code.

This was my fault entirely; sorry about that.

I'd wanted to ensure that we got build coverage regardless of the kernel
configuration, which was why i'd used __is_defined().

Thanks,
Mark.
