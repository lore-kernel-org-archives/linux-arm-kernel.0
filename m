From: buildroot@browserseal.com (Sasha Sirotkin)
Date: Sat, 17 Apr 2010 10:44:15 +0300
Subject: Question about ARM set_pte_ext
Message-ID: <4BC966CF.9040503@browserseal.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm still trying to understand the peculiarities of ARMv5 memory 
management...

I have a question about ARM set_pte_ext or armv3_set_pte_ext to be more 
specific.
In the following lines

    tst    r3, #L_PTE_USER            @ user?
    orrne    r2, r2, #PTE_SMALL_AP_URO_SRW

We are testing for L_PTE_USER not being set. Why not?

Another question is about S & R bits of CP15 register 1, which on ARMv5 
are used to control memory access in combination with AP bits. As 
changing S & R bits requires to reset the MMU, basically it is 
impossible to use them, if I wanted to configured a certain page to be, 
for instance, read-only for both kernel and user modes?

Thanks.
