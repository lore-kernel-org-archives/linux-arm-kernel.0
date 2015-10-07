From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 08:12:06 +0100
Subject: [PATCH v2 1/1] irqchip/GICv2m: Add workaround for APM X-Gene
 GICv2m erratum
In-Reply-To: <b0fcb89a51a86b5edb85d2b03cf26ca60bd51f01.1444069886.git.dhdang@apm.com>
References: <20151003142650.16b291b4@arm.com>
 <b0fcb89a51a86b5edb85d2b03cf26ca60bd51f01.1444069886.git.dhdang@apm.com>
Message-ID: <5614C5C6.5090207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 23:32, Duc Dang wrote:
> APM X-Gene GICv2m implementation has an erratum where the
> MSI data needs to be the offset from the spi_start in order to
> trigger the correct MSI interrupt. This is different from the
> standard GICv2m implementation where the MSI data is the absolute
> value within the range from spi_start to (spi_start + num_spis)
> of each v2m frame.
> 
> This patch reads MSI_IIDR register (present in all GICv2m
> implementations) to identify X-Gene GICv2m implementation and
> apply workaround to change the data portion of MSI vector.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
