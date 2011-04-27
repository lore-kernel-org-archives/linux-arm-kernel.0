From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Apr 2011 18:10:34 +0100
Subject: cachepolicy on arm UP/SMP
In-Reply-To: <163eed8.b6ba.12f1441357c.Coremail.bill_carson@126.com>
References: <163eed8.b6ba.12f1441357c.Coremail.bill_carson@126.com>
Message-ID: <BANLkTi=6t=iLNcWPCtOoDai50A5N9m08UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/2 rocky <bill_carson@126.com>:
> I am a little confused about arm cachepolicy for UP/SMP.
>
> in arch/arm/mm/mmu.c
> for UP , default cache policy is CPOLICY_WRITEBACK;
> while for SMP, cache policy is overrided with? WRITEALLOC.
>
> why does SMP cannot use WRITEBACK?
> It is about coherency issue?

Historical reasons I think because ARM11MPCore only supported WBWA
caches, though even if only WB configuration was set.

Note that WB or WBWA is just a hint and the processor is allowed to do
write allocation or ignore it. We could simply make both the same at
least on ARMv6+ hardware (and I'm more in favour of WBWA).

-- 
Catalin
