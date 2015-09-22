From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 17:52:40 +0100
Subject: [PATCH v5 5/6] irqchip, gicv3-its: Workaround for Cavium
 ThunderX errata 22375, 24313
In-Reply-To: <1442869119-1814-6-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <1442869119-1814-6-git-send-email-rric@kernel.org>
Message-ID: <20150922175240.7e04b200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 22:58:38 +0200
Robert Richter <rric@kernel.org> wrote:

> From: Robert Richter <rrichter@cavium.com>
> 
> This implements two gicv3-its errata workarounds for ThunderX. Both
> with small impact affecting only ITS table allocation.
> 
>  erratum 22375: only alloc 8MB table size
>  erratum 24313: ignore memory access type
> 
> The fixes are in ITS initialization and basically ignore memory access
> type and table size provided by the TYPER and BASER registers.
> 
> v5:
>  * fix table size wrongly allocating only 4MB
>  * introduced CAVIUM_ERRATUM_22375 config option
>  * added config description
>  * introduced ITS_FLAGS_WORKAROUND_CAVIUM_22375
> 
> v3:
>  * fix erratum to be dependend from iidr
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
