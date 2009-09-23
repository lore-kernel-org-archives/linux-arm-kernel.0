From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Sep 2009 22:12:15 +0100
Subject: [PATCH v4, REBASED 1/2] ARM: Pass IFSR register to
	do_PrefetchAbort()
In-Reply-To: <00ae0c0830ca659709d80e56e8e87b636c32fcf6.1253616961.git.kirill@shutemov.name>
References: <00ae0c0830ca659709d80e56e8e87b636c32fcf6.1253616961.git.kirill@shutemov.name>
Message-ID: <20090923211214.GA25115@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2009 at 02:00:14PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 379f785..924ec14 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -520,7 +520,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  }
>  
>  asmlinkage void __exception
> -do_PrefetchAbort(unsigned long addr, struct pt_regs *regs)
> +do_PrefetchAbort(unsigned long addr, int ifsr, struct pt_regs *regs)

Almost there - this should be 'unsigned int ifsr'.

Other than that, patches are fine.
