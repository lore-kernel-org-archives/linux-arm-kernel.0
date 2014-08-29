From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Aug 2014 11:10:39 +0100
Subject: [PATCH] Doc: dt: arch_timer: discourage clock-frequency use
In-Reply-To: <1409251024-19103-1-git-send-email-mark.rutland@arm.com>
References: <1409251024-19103-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140829101039.GA9453@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 07:37:04PM +0100, Mark Rutland wrote:
> The ARM Generic Timer (AKA the architected timer, arm_arch_timer)
> features a CPU register (CNTFRQ) which firmware is intended to
> initialize, and non-secure software can read to determine the frequency
> of the timer. On CPUs with secure state, this register cannot be written
> from non-secure states.
> 
> The firmware of early SoCs featuring the timer did not correctly
> initialize CNTFRQ correctly on all CPUs, requiring the frequency to be
> described in DT as a workaround. This workaround is not complete however
> as it is exposed to all software in a privileged non-secure mode
> (including guests running under a hypervisor). The firmware and DTs for
> recent SoCs have followed the example set by these early SoCs.
> 
> This patch updates the arch timer binding documentation to make it
> clearer that the use of the clock-frequency property is a poor
> work-around. The MMIO generic timer binding is similarly updated, though
> this is less of a concern as there is generally no need to expose the
> MMIO timers to guest OSs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Olof Johansson <olof@lixom.net>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
