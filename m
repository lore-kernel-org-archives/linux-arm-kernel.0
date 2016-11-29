From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Nov 2016 11:37:32 +0000
Subject: [PATCH v2] arm64: head.S: Fix CNTHCTL_EL2 access on VHE system
In-Reply-To: <1480385582-24176-1-git-send-email-jintack@cs.columbia.edu>
References: <1480385582-24176-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20161129113732.GC13725@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 09:13:02PM -0500, Jintack Lim wrote:
> From: Jintack <jintack@cs.columbia.edu>
> 
> Bit positions of CNTHCTL_EL2 are changing depending on HCR_EL2.E2H bit.
> EL1PCEN and EL1PCTEN are 1st and 0th bits when E2H is not set, but they
> are 11th and 10th bits respectively when E2H is set.  Current code is
> unintentionally setting wrong bits to CNTHCTL_EL2 with E2H set.
> 
> In fact, we don't need to set those two bits, which allow EL1 and EL0 to
> access physical timer and counter respectively, if E2H and TGE are set
> for the host kernel. They will be configured later as necessary. First,
> we don't need to configure those bits for EL1, since the host kernel
> runs in EL2.  It is a hypervisor's responsibility to configure them
> before entering a VM, which runs in EL0 and EL1. Second, EL0 accesses
> are configured in the later stage of boot process.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Queued for 4.10. Thanks.

-- 
Catalin
