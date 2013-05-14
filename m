From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 May 2013 14:05:40 +0100
Subject: [PATCH v3 3/7] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <1368529900-22572-4-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130514130539.GI21175@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:11:36PM +0100, Marc Zyngier wrote:
> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> introduced code that flushes page tables to the point of coherency.
> This is overkill (point of unification is enough and already done),
> and actually not required if running on a SMP capable platform
> (the HW PTW can snoop other cpus' L1).
> 
> Remove this code and let ae8a8b9553bd (ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead) turn it into
> a no-op for SMP ARMv7.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
