From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 17:51:45 +0100
Subject: [PATCH v5 4/6] irqchip, gicv3-its: Add HW revision detection
 and configuration
In-Reply-To: <1442869119-1814-5-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <1442869119-1814-5-git-send-email-rric@kernel.org>
Message-ID: <20150922175145.72f5a589@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 22:58:37 +0200
Robert Richter <rric@kernel.org> wrote:

> From: Robert Richter <rrichter@cavium.com>
> 
> Some GIC revisions require an individual configuration to esp. add
> workarounds for HW bugs. This patch implements generic code to parse
> the hw revision provided by an IIDR register value and runs specific
> code if hw matches. A function is added that reads the IIDR registers
> for ITS (GITS_IIDR) and then goes through a list of init functions to
> be called for specific versions. Same could be done for GICV3
> (GICD_IIDR), but there are no users yet for it.
> 
> The patch is needed to implement workarounds for HW errata in Cavium's
> ThunderX GICV3 ITS.
> 
> v5:
>  * renamed caps names to quirk
> 
> v4:
>  * only enable hw detection for its in its_enable_quirks()
>  * removed gicv3_check_capabilities()
> 
> v3:
>  * use arm64 errata framework for midr check
> 
> v2:
>  * adding MIDR check
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
