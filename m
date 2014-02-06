From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 10:49:05 +0000
Subject: [PATCH v3 06/11] ARM: KVM: force cache clean on page fault
 when caches are off
In-Reply-To: <1391630151-7875-7-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140206104904.GC29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:46PM +0000, Marc Zyngier wrote:
> In order for a guest with caches disabled to observe data written
> contained in a given page, we need to make sure that page is
> committed to memory, and not just hanging in the cache (as guest
> accesses are completely bypassing the cache until it decides to
> enable it).
> 
> For this purpose, hook into the coherent_cache_guest_page
> function and flush the region if the guest SCTLR
> register doesn't show the MMU and caches as being enabled.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
