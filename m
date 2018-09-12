From: james.morse@arm.com (James Morse)
Date: Wed, 12 Sep 2018 11:32:21 +0100
Subject: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
In-Reply-To: <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
Message-ID: <641119b9-3466-817d-3d6b-dd710c646b49@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> For EL0 entries requiring bp_hardening, daif status is kept at
> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
> are enabled through local_irq_enable().
> 
> Before using local_irq_* functions, daifflags should be properly restored
> to a state where IRQs are enabled.

> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.

Is this just for symmetry, or are you going on to add something to the daifflags
state that local_irq_* functions won't change? (if so, could you allude to that
in the commit message)


Either way,

Acked-by: James Morse <james.morse@arm.com>
