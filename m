From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:24:36 +0100
Subject: [PATCHv3 12/19] arm64: zero GPRs upon entry from EL0
In-Reply-To: <20180618120310.39527-13-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-13-mark.rutland@arm.com>
Message-ID: <20180619152436.7lvsmiq2wseo4u6e@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:03PM +0100, Mark Rutland wrote:
> We can zero GPRs x0 - x29 upon entry from EL0 to make it harder for
> userspace to control values consumed by speculative gadgets.
> 
> We don't blat x30, since this is stashed much later, and we'll blat it
> before invoking C code.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
