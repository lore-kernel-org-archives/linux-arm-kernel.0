From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Nov 2010 13:12:35 -0000
Subject: Weirdo gcc 4.3.x behaviour
In-Reply-To: <20101121191148.GA12234@n2100.arm.linux.org.uk>
References: <20101121191148.GA12234@n2100.arm.linux.org.uk>
Message-ID: <000201cb8a46$ee3f70f0$cabe52d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Has anyone else seen weird behaviour from the gcc 4.3 branch?
> 
> I've tried gcc-4.3.2 + patch and also gcc-4.3.5, both of which behave
> differently with this change in the kernel:
> 
> (asm-generic/pgtable-nopud.h)
> static inline int pgd_none(pgd_t pgd)           { return 0; }
> static inline int pgd_bad(pgd_t pgd)            { return 0; }
> static inline int pgd_present(pgd_t pgd)        { return 1; }
> 
> and subsequently adding:
> +#define pgd_none(pgd)          0
> +#define pgd_bad(pgd)           0
> +#define pgd_present(pgd)       1
> 
> This causes completely unrelated functions to be optimized differently,
> as can be seen via the bloat-o-meter:

[...]

If you mail me the smallest diff to the kernel which causes this to
happen along with the .s/.i files (gcc --save-temps) for the file that
is changing then I'll pass the information on to the compiler guys at
ARM.

Thanks,

Will
