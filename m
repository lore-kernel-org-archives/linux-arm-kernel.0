From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 18 Jan 2017 12:16:48 -0300
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <e2295a5d-3224-1198-8b46-f45b153b540a@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On 01/18/2017 07:53 AM, Marc Zyngier wrote:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
> 
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
> 
> In the couple of cases were I knew for sure what implementation
> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the
> TRM for all the other SoCs, I've let them alone.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi    | 2 +-
>  arch/arm/boot/dts/exynos5.dtsi       | 2 +-
>  arch/arm/boot/dts/exynos5260.dtsi    | 2 +-
>  arch/arm/boot/dts/exynos5440.dtsi    | 2 +-

I've looked at the Exynos5250 and Exynos5420 TRM and both say that adopts
GIC-400, so I think it's safe for you to also update the compatible in the
exynos5.dtsi. Unfortunately I don't have manuals for 3250, 5260 and 5440.

The register map changes looks good to me, so for Exynos:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
