From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Dec 2017 15:42:09 +0000
Subject: [PATCH v2 7/8] arm64: allow ID map to be extended to 52 bits
In-Reply-To: <20171222152307.11252-8-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-8-catalin.marinas@arm.com>
Message-ID: <e88df097-b7b6-6dcd-2873-3408ee0d810b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> Currently, when using VA_BITS < 48, if the ID map text happens to be
> placed in physical memory above VA_BITS, we increase the VA size (up to
> 48) and create a new table level, in order to map in the ID map text.
> This is okay because the system always supports 48 bits of VA.
> 
> This patch extends the code such that if the system supports 52 bits of
> VA, and the ID map text is placed that high up, then we increase the VA
> size accordingly, up to 52.
> 
> One difference from the current implementation is that so far the
> condition of VA_BITS < 48 has meant that the top level table is always
> "full", with the maximum number of entries, and an extra table level is
> always needed. Now, when VA_BITS = 48 (and using 64k pages), the top
> level table is not full, and we simply need to increase the number of
> entries in it, instead of creating a new table level.
> 
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> [catalin.marinas at arm.com: reduce arguments to __create_hyp_mappings()]
> [catalin.marinas at arm.com: reworked/renamed __cpu_uses_extended_idmap_level()]

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
