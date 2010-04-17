From: milinevskyy@gmail.com (Dmytro Milinevskyy)
Date: Sat, 17 Apr 2010 14:16:14 +0300
Subject: Question about ARM set_pte_ext
In-Reply-To: <4BC966CF.9040503@browserseal.com>
References: <4BC966CF.9040503@browserseal.com>
Message-ID: <i2ia9e22dff1004170416v64323d4cr3da5382f05f1019e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Sasha.
You are misunderstanding ARM ASM.
tst operation is updating flags on Rn & Rd, so if L_PTE_USER was set
in r3, then Z flag is not set and orrne operation will be performed,
because {ne} conditional states to execute operation if Z was not set.
So if r3 has L_PTE_USER then r2 will be orred with
PTE_SMALL_AP_URO_SRW

-- Dima

On Sat, Apr 17, 2010 at 10:44 AM, Sasha Sirotkin
<buildroot@browserseal.com> wrote:
> I'm still trying to understand the peculiarities of ARMv5 memory
> management...
>
> I have a question about ARM set_pte_ext or armv3_set_pte_ext to be more
> specific.
> In the following lines
>
> ? tst ? ?r3, #L_PTE_USER ? ? ? ? ? ?@ user?
> ? orrne ? ?r2, r2, #PTE_SMALL_AP_URO_SRW
>
> We are testing for L_PTE_USER not being set. Why not?
>
> Another question is about S & R bits of CP15 register 1, which on ARMv5 are
> used to control memory access in combination with AP bits. As changing S & R
> bits requires to reset the MMU, basically it is impossible to use them, if I
> wanted to configured a certain page to be, for instance, read-only for both
> kernel and user modes?
>
> Thanks.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
