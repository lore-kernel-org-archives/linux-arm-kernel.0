From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jun 2016 09:56:58 +0100
Subject: [PATCH V6 5/7] irqchip/gicv3-its: Probe ITS in the ACPI way
In-Reply-To: <1465828873-23498-6-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-6-git-send-email-tn@semihalf.com>
Message-ID: <20160615095658.48b52888@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2016 16:41:11 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> ITS is prepared for being initialized different than DT,
> therefore we can initialize it in ACPI way. We collect register base
> address from MADT table and pass mandatory info to firmware-agnostic
> ITS init call.
> 
> Use here IORT lib to register ITS domain which then can be found and
> used on to build another PCI MSI domain in hierarchical stack domain.
> 
> NOTE: Waiting for proper ITS and NUMA node relation description in IORT
> table, we pass around NUMA_NO_NODE to the its_probe_one init call.
> This means that Cavium ThunderX erratum 23144 (pass1.1 only)
> is not supported for ACPI boot method yet.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
