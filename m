From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 10:53:31 +0000
Subject: [PATCH 1/2] Fix the I-cache invalidation on ARMv6 and later CPUs
In-Reply-To: <AANLkTinL_quoDUL=_aT9d-Tdi4wEFPf59JLCBH-Ybc7h@mail.gmail.com>
References: <20080606114622.15520.49929.stgit@pc1117.cambridge.arm.com>
	<AANLkTik0_0Eb8G5hEb+DGvE2BDM_mJwwF-Pt1ErTz=Lr@mail.gmail.com>
	<AANLkTim3O9HaOZp7VD3s1+FRU0KmPUrDei9NFDoXWK3y@mail.gmail.com>
	<1289297870.11461.7.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikhi3znQs32Qc=ACuH0Kz-WV0xmD-4-JjQv8OqZ@mail.gmail.com>
	<20101109103836.GC2869@n2100.arm.linux.org.uk>
	<AANLkTinL_quoDUL=_aT9d-Tdi4wEFPf59JLCBH-Ybc7h@mail.gmail.com>
Message-ID: <20101109105331.GD2869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 07:52:15PM +0900, Minchan Kim wrote:
> Thanks, I understand the problem by your kind explanation.
> So, why don't we use flush_icache_page?
> 
> page fault
> read
> flush_icache_page <------ here
> set_pte_at
> update_mmu_cache

Have you read Documentation/cachetlb.txt ?
