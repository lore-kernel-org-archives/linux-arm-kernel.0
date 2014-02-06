From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 10:50:23 +0000
Subject: [PATCH v3 08/11] ARM: KVM: fix ordering of 64bit coprocessor
 accesses
In-Reply-To: <1391630151-7875-9-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140206105022.GE29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:48PM +0000, Marc Zyngier wrote:
> Commit 240e99cbd00a (ARM: KVM: Fix 64-bit coprocessor handling)
> added an ordering dependency for the 64bit registers.
> 
> The order described is: CRn, CRm, Op1, Op2, 64bit-first.
> 
> Unfortunately, the implementation is: CRn, 64bit-first, CRm...
> 
> Move the 64bit test to be last in order to match the documentation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
