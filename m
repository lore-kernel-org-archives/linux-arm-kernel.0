From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 May 2018 16:52:25 +0100
Subject: [PATCH 1/4] arm64: KVM: Add support for Stage-2 control of
 memory types and cacheability
In-Reply-To: <20180517103548.5622-2-marc.zyngier@arm.com>
References: <20180517103548.5622-1-marc.zyngier@arm.com>
 <20180517103548.5622-2-marc.zyngier@arm.com>
Message-ID: <20180524155224.5prjpe6cnozm4tpl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:35:45AM +0100, Marc Zyngier wrote:
> Up to ARMv8.3, the combinaison of Stage-1 and Stage-2 attributes
> results in the strongest attribute of the two stages.  This means
> that the hypervisor has to perform quite a lot of cache maintenance
> just in case the guest has some non-cacheable mappings around.
> 
> ARMv8.4 solves this problem by offering a different mode (FWB) where
> Stage-2 has total control over the memory attribute (this is limited
> to systems where both I/O and instruction caches are coherent with
> the dcache). This is achieved by having a different set of memory
> attributes in the page tables, and a new bit set in HCR_EL2.
> 
> On such a system, we can then safely sidestep any form of dcache
> management.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

For the core arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
