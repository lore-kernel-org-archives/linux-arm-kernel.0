From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:10:59 +0000
Subject: [PATCH v5 04/23] arm64: KVM: Dynamically patch the kernel/hyp VA
 mask
In-Reply-To: <20180301155538.26860-5-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-5-marc.zyngier@arm.com>
Message-ID: <20180307181059.7nssh2amhvrvh2v7@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:19PM +0000, Marc Zyngier wrote:
> So far, we're using a complicated sequence of alternatives to
> patch the kernel/hyp VA mask on non-VHE, and NOP out the
> masking altogether when on VHE.
> 
> The newly introduced dynamic patching gives us the opportunity
> to simplify that code by patching a single instruction with
> the correct mask (instead of the mind bending cummulative masking
> we have at the moment) or even a single NOP on VHE. This also
> adds some initial code that will allow the patching callback
> to switch to a more complex patching.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
