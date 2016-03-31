From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 31 Mar 2016 09:15:15 +0100
Subject: [PATCH v2] arm64: KVM: Register CPU notifiers when the kernel
 runs at HYP
In-Reply-To: <1459359184-15601-1-git-send-email-james.morse@arm.com>
References: <1459359184-15601-1-git-send-email-james.morse@arm.com>
Message-ID: <56FCDC93.3070304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/16 18:33, James Morse wrote:
> When the kernel is running at EL2, it doesn't need init_hyp_mode() to
> configure page tables for HYP. This function also registers the CPU
> hotplug and lower power notifiers that cause HYP to be re-initialised
> after the CPU has been reset.
> 
> To avoid losing the register state that controls stage2 translation, move
> the registering of these notifiers into init_subsystems(), and add a
> is_kernel_in_hyp_mode() path to each callback.
> 
> Fixes: 1e947bad0b6 ("arm64: KVM: Skip HYP setup when already running in HYP")
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
