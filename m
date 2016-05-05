From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 May 2016 17:39:37 +0100
Subject: [PATCH v3] irqchip/gic-v2m: Add workaround for Broadcom NS2
 GICv2m erratum
In-Reply-To: <1462465921-3220-2-git-send-email-ray.jui@broadcom.com>
References: <1462465921-3220-1-git-send-email-ray.jui@broadcom.com>
 <1462465921-3220-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <572B7749.3070708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/16 17:32, Ray Jui wrote:
> Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
> implementation has an erratum where the MSI data needs to be the SPI
> number subtracted by an offset of 32, for the correct MSI interrupt
> to be triggered.
> 
> Here we are adding the workaround based on readings from the MSI_IIDR
> register, which contains a value unique to Broadcom NS2 GICv2m
> 
> Reported-by: Alex Barba <alex.barba@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll queue that for 4.7.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
