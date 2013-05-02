From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 16:00:29 +0100
Subject: [PATCH v2 3/5] ARM: KVM: relax cache maintainance when
 building page tables
In-Reply-To: <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130502150028.GF20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:39:00PM +0100, Marc Zyngier wrote:
> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> introduced code that flushes page tables to the point of coherency.
> This is overkill (point of unification is enough and already done),
> and actually not required if running on a SMP capable platform
> (the HW PTW can snoop other cpus' L1).
> 
> Remove this code and let ae8a8b9553bd (ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead) turn it into
> a no-op for SMP ARMv7.

I think the comment is a bit misleading. You actually don't need
kvm_flush_dcache_to_poc() since you already do this in kvm_set_pte()
etc.

-- 
Catalin
