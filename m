From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2017 15:26:24 +0000
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <e2295a5d-3224-1198-8b46-f45b153b540a@osg.samsung.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
 <e2295a5d-3224-1198-8b46-f45b153b540a@osg.samsung.com>
Message-ID: <90ab45ff-3995-600d-c263-e6d350a35aaf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/17 15:16, Javier Martinez Canillas wrote:
> Hello Marc,
> 
> On 01/18/2017 07:53 AM, Marc Zyngier wrote:
>> Since everybody copied my own mistake from the DT binding example,
>> let's address all the offenders in one swift go.
>>
>> Most of them got the CPU interface size wrong (4kB, while it should
>> be 8kB), except for both keystone platforms which got the control
>> interface wrong (4kB instead of 8kB).
>>
>> In the couple of cases were I knew for sure what implementation
>> was used, I've added the "arm,gic-400" compatible string. I'm 99%
>> sure that this is what everyong is using, but short of having the
>> TRM for all the other SoCs, I've let them alone.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/exynos3250.dtsi    | 2 +-
>>  arch/arm/boot/dts/exynos5.dtsi       | 2 +-
>>  arch/arm/boot/dts/exynos5260.dtsi    | 2 +-
>>  arch/arm/boot/dts/exynos5440.dtsi    | 2 +-
> 
> I've looked at the Exynos5250 and Exynos5420 TRM and both say that adopts
> GIC-400, so I think it's safe for you to also update the compatible in the
> exynos5.dtsi. Unfortunately I don't have manuals for 3250, 5260 and 5440.

Thanks for taking the time to find out, I'll update the patch.

> 
> The register map changes looks good to me, so for Exynos:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thank you.

	M.
-- 
Jazz is not dead. It just smells funny...
