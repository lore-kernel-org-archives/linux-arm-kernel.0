From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Sep 2016 09:44:37 +0100
Subject: [PATCH v3 8/9] arm64: Refactor sysinstr exception handling
In-Reply-To: <1473069509-2317-9-git-send-email-suzuki.poulose@arm.com>
References: <1473069509-2317-1-git-send-email-suzuki.poulose@arm.com>
 <1473069509-2317-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160907084436.GD32499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 10:58:28AM +0100, Suzuki K Poulose wrote:
> Right now we trap some of the user space data cache operations
> based on a few Errata (ARM 819472, 826319, 827319 and 824069).
> We need to trap userspace access to CTR_EL0, if we detect mismatched
> cache line size. Since both these traps share the EC, refactor
> the handler a little bit to make it a bit more reader friendly.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 76 ++++++++++++++++++++++++++++++++++++++------
>  arch/arm64/kernel/traps.c    | 73 +++++++++++++++++++++++++++---------------
>  2 files changed, 114 insertions(+), 35 deletions(-)

This looks fine to me, but I'd really like to see Andre's ack on the
refactoring of the errata workarounds.

Andre, can you take a look please?

Will
