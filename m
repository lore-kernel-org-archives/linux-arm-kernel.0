From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 26 Feb 2015 14:43:21 -0800
Subject: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Message-ID: <54EFA189.3010509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2015 02:38 PM, Andrew Morton wrote:
[...]
>
> From: Andrew Morton<akpm@linux-foundation.org>
> Subject: fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
>
> Consolidate randomize_et_dyn() implementations into fs/binfmt_elf.c.
>
> There doesn't seem to be a compile-time way of making randomize_et_dyn()
> go away on architectures which don't need it, so mark it __weak to cause
> it to be discarded at link time.
>
> Cc: "H. Peter Anvin"<hpa@zytor.com>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Hector Marco Gisbert<hecmargi@upv.es>
> Cc: Hector Marco-Gisbert<hecmargi@upv.es>
> Cc: Ingo Molnar<mingo@kernel.org>
> Cc: Ismael Ripoll<iripoll@upv.es>
> Cc: Kees Cook<keescook@chromium.org>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Russell King<rmk@arm.linux.org.uk>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Will Deacon<will.deacon@arm.com>
> Signed-off-by: Andrew Morton<akpm@linux-foundation.org>
[...]
> diff -puN arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/include/asm/elf.h
> --- a/arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/include/asm/elf.h
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 20q12 ARM Ltd.

This particular change looks like it may be a typo.

>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
