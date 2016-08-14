From: alexander.levin@verizon.com (Levin, Alexander)
Date: Sun, 14 Aug 2016 11:27:33 -0400
Subject: [E] [stable:PATCH 1/2] arm64: kernel: Save and restore
 addr_limit on exception entry
In-Reply-To: <1471025480-10394-1-git-send-email-james.morse@arm.com>
References: <1471025480-10394-1-git-send-email-james.morse@arm.com>
Message-ID: <b1746053-fe21-0c45-5528-b1143a6df85f@verizon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 02:11 PM, James Morse wrote:
> commit e19a6ee2460bdd0d0055a6029383422773f9999a upstream.
> 
> If we take an exception while at EL1, the exception handler inherits
> the original context's addr_limit value. To be consistent always reset
> addr_limit and PSTATE.UAO on (re-)entry to EL1. This prevents accidental
> re-use of the original context's addr_limit.
> 
> Based on a similar patch for arm from Russell King.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> [ backport to stop perf misusing inherited addr_limit.
>   Removed code interacting with UAO and the irqstack ]
> Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=822
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: <stable@vger.kernel.org> #4.1

Added, thanks!
