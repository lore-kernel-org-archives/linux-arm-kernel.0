From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 28 Jul 2013 19:58:08 +0000 (UTC)
Subject: [PATCH v2] ARM: v6: avoid remaining accesses to missing CP15
 registers on ARM1136 r0
In-Reply-To: <alpine.DEB.2.02.1307280559330.8385@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280527430.8385@utopia.booyaka.com>
 <alpine.DEB.2.02.1307280543370.8385@utopia.booyaka.com>
 <alpine.DEB.2.02.1307280559330.8385@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1307281956420.23852@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Jul 2013, Paul Walmsley wrote:

> Ensure that the remaining callers of read_cpuid_ext can't attempt an 
> extended CP15 register read on ARMv6 cores that don't support it.  The 
> only one that appears dodgy is tlb_ops_need_broadcast().
> 
> While here, convert feat_v6_fixup() to use cpu_is_arm1136_r0() to save
> a few lines of code.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

For the archives - this one can be ignored; the cpu_is_arm1136_r0() isn't 
needed due to the SMP-on-UP code.


- Paul
