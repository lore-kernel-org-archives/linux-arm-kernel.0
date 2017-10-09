From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Mon, 9 Oct 2017 14:59:09 -0400
Subject: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
In-Reply-To: <20171009184834.GE30828@arm.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
 <20171009171337.GE30085@arm.com>
 <CAOAebxtHHFvYn4WysMASe1GqvgKYPVyjJ572UM3Sef5sP0hi9A@mail.gmail.com>
 <20171009182217.GC30828@arm.com>
 <CAOAebxu1310eCrk88EC=Oaw3n90-9RuHZ1KBhPvLu_DyXBNZFQ@mail.gmail.com>
 <20171009184834.GE30828@arm.com>
Message-ID: <CAOAebxs5s3DKV8f+Zw+LFVB98PE6cs=RwcOH8qEiU_MPLM9RvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> We have two table walks even with your patch series applied afaict: one in
> our definition of vmemmap_populate (arch/arm64/mm/mmu.c) and this one
> in the core code.

I meant to say implementing two new page table walkers, not at runtime.

> My worry is that these are actually highly arch-specific, but will likely
> grow more users in mm/ that assume things for all architectures that aren't
> necessarily valid.

I see, how about moving new kasan_map_populate() implementation into
arch dependent code:

arch/x86/mm/kasan_init_64.c
arch/arm64/mm/kasan_init.c

This way we won't need to add pmd_large()/pud_large() macros for arm64?

Pavel
