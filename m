From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 10:30:46 +0000
Subject: [PATCH V3 05/10] irqchip, gicv3, its: Mark its_init() and its
 children as __init
In-Reply-To: <1453209083-3358-6-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-6-git-send-email-tn@semihalf.com>
Message-ID: <56BB1156.4070507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> gicv3_init_bases() is the only caller for its_init(),
> also it is a __init function, so mark its_init() as __init too,
> then recursively mark the functions called as __init.
> 
> This will help to introduce ITS initialization using ACPI tables as
> we will use acpi_table_parse_entries family functions there which
> belong to __init section as well.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
