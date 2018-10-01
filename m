From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 16:56:19 +0100
Subject: [PATCH v3] arm64: Trap WFI executed in userspace
In-Reply-To: <20181001111943.233042-1-marc.zyngier@arm.com>
References: <20181001111943.233042-1-marc.zyngier@arm.com>
Message-ID: <20181001155619.GI25071@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 12:19:43PM +0100, Marc Zyngier wrote:
> It recently came to light that userspace can execute WFI, and that
> the arm64 kernel doesn't trap this event. This sounds rather benign,
> but the kernel should decide when it wants to wait for an interrupt,
> and not userspace.
> 
> Let's trap WFI and immediately return after having skipped the
> instruction. This effectively makes WFI a rather expensive NOP.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
