From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:40:53 +0100
Subject: [PATCH v4 4/5] arm64: Verify CPU errata work arounds on
 hotplugged CPU
In-Reply-To: <1461324335-5081-5-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
 <1461324335-5081-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160422134053.GL2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:25:34PM +0100, Suzuki K. Poulose wrote:
> CPU Errata work arounds are detected and applied to the
> kernel code at boot time and the data is then freed up.
> If a new hotplugged CPU requires a work around which
> was not applied at boot time, there is nothing we can
> do but simply fail the booting.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I think Will commented on this previously. Was a decision made to leave
this patch as it is and subsequently add support for enabling local
workarounds for hot-plugged CPUs? I'm fine with this given that most
per-CPU workarounds like undocumented bits are set by firmware. But I'd
like to see it done properly once we have a workaround that needs
per-CPU enabling.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
