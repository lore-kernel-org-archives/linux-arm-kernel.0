From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 10:49:58 +0000
Subject: [PATCH v3 07/11] ARM: KVM: fix handling of trapped 64bit
 coprocessor accesses
In-Reply-To: <1391630151-7875-8-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140206104958.GD29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:47PM +0000, Marc Zyngier wrote:
> Commit 240e99cbd00a (ARM: KVM: Fix 64-bit coprocessor handling)
> changed the way we match the 64bit coprocessor access from
> user space, but didn't update the trap handler for the same
> set of registers.
> 
> The effect is that a trapped 64bit access is never matched, leading
> to a fault being injected into the guest. This went unnoticed as we
> didn't really trap any 64bit register so far.
> 
> Placing the CRm field of the access into the CRn field of the matching
> structure fixes the problem. Also update the debug feature to emit the
> expected string in case of failing match.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
