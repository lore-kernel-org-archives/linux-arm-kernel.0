From: bill4carson@gmail.com (carson bill)
Date: Tue, 7 Feb 2012 23:41:29 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <20120207150900.GK3351@arm.com>
References: <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
 <4F28AD1D.1000106@gmail.com> <20120206162656.GG26538@arm.com>
 <4F308169.4010904@gmail.com> <20120207115058.GD3351@arm.com>
 <CAOMgcGLhGyz5xU1P2C=Av9LWazJF3X=U14riNi=xESZX68mdwQ@mail.gmail.com>
 <20120207141100.GI3351@arm.com>
 <CAOMgcG+rtHynsSe71onpL-Mp2dLq6Rv-7hLmj2noy7zx-QtTuQ@mail.gmail.com>
 <20120207150900.GK3351@arm.com>
Message-ID: <CAOMgcG+YXgLztMYb0o8LmkaO3Doj3RRuUJ2rROoPCc5cMSmoRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/7, Catalin Marinas <catalin.marinas@arm.com>:
> On Tue, Feb 07, 2012 at 02:46:50PM +0000, carson bill wrote:
>> 2012/2/7, Catalin Marinas <catalin.marinas@arm.com>:
>> > But if you avoid setting L_PTE_HPAGE_*, than we don't need the
>> > masking for pte_pfn. In which case, we don't need to differentiate
>> > between a normal and a huge pte in pte_pfn(), so no need for
>> > L_PTE_HUGEPAGE. The set_huge_pte_at() function is only called with a
>> > huge pte, so it doesn't need to check the L_PTE_HUGEPAGE bit either.
>>
>> I understood what you mean now, and the original design is almost like
>> you said.  But the consequences of eliminating L_PTE_HUGEPAGE as well
>> as L_PTE_HPAGE_* only leave us with huge page size fixed at build
>> time, I mean boot time huge page size configuration feature like X86
>> will NOT be feasible anymore!
>
> Yes it will :). Just store the page size in some variable that you check
> at run-time. We won't support mixed huge page sizes though.
>

Got it:)
Please review the other parts of patch, let me know if any question arises.



> --
> Catalin
>
