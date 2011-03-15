From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Mar 2011 16:49:52 +0000
Subject: One quick question about SMP on ARM
In-Reply-To: <4e9f0255.13eed.12e6c6d8194.Coremail.bill_carson@126.com>
References: <4e9f0255.13eed.12e6c6d8194.Coremail.bill_carson@126.com>
Message-ID: <AANLkTi=EexE4yyXhmG3uz+1S7bX3K0LVr1D5_OQPkBa_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/28 rocky <bill_carson@126.com>:
> I am puzzled these day on three issues for SMP ARM in terms of hardware:
> 1: Is MMU global or per cpu ?

Both (if you mean a set of page tables).

> 2: Is MicroTLB/MainTLB global or per cpu ?

Per CPU.

> I read the code, each cpu has to set its own pgd base addr into TBBR0,so I
> draw the conclusion MMU is per cpu;

Yes, but they could also point to the same TTB, for example when a
multithreaded application has threads running on different CPUs.

> ASID is shared between each cpu, while when ASID rollover from 0xff back to
> 0x0, each cpu has to call local_flush_tlb_all to invalidate I/D tlb; Does
> that mean MicroTLB/MainTLB is also per cpu; then why all cpu shared ASID
> from 0x0~0xff ?

Because of point 1 above.

-- 
Catalin
