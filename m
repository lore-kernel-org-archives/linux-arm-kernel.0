From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2018 16:12:41 +0100
Subject: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
In-Reply-To: <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
Message-ID: <20181003151240.GE12998@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:51:15PM +0100, Julien Thierry wrote:
> For EL0 entries requiring bp_hardening, daif status is kept at
> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
> are enabled through local_irq_enable().
> 
> Before using local_irq_* functions, daifflags should be properly restored
> to a state where IRQs are enabled.
> 
> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
