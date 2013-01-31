From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:36:13 +0000
Subject: [PATCHv5 09/16] arm: arch_timer: add arch_counter_set_user_access
In-Reply-To: <1359634539-9580-10-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-10-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153613.GJ12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:32PM +0000, Mark Rutland wrote:
> Several bits in CNTKCTL reset to 0, including PL0VTEN. For architectures
> using the generic timer which wish to have a fast gettimeofday vDSO
> implementation, these bits must be set to 1 by the kernel. For
> architectures without a vDSO, it's best to leave the bits set to 0 for
> now to ensure that if and when support is added, it's implemented sanely
> architecture wide.
> 
> As the bootloader might set PL0VTEN to a value that doesn't correspond
> to that which the kernel prefers, we must explicitly set it to the
> architecture port's preferred value.
> 
> This patch adds arch_counter_set_user_access, which sets the PL0 access
> permissions to that required by the architecture. For arch/arm, this
> currently means disabling all userspace access.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
