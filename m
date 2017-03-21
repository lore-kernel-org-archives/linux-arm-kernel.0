From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 15:43:32 +0000
Subject: [PATCH 1/2] arm64: reduce el2_setup branching
In-Reply-To: <1487170457-17986-2-git-send-email-mark.rutland@arm.com>
References: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
 <1487170457-17986-2-git-send-email-mark.rutland@arm.com>
Message-ID: <3832b7de-ef7c-8e7c-c9b0-de3e1f44cbb0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/17 14:54, Mark Rutland wrote:
> The early el2_setup code is a little convoluted, with two branches where
> one would do. This makes the code more painful to read than is
> necessary.
> 
> We can remove a branch and simplify the logic by moving the early return
> in the booted-at-EL1 case earlier in the function. This separates it
> from all the setup logic that only makes sense for EL2.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
