From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 25 May 2016 10:17:52 -0400
Subject: [PATCH 0/2] ARM: dts: Fix imprecise external abort error when
 accessing Exynos MFC
In-Reply-To: <6479e0c0-97fb-ca3b-1337-6ed11410d94f@samsung.com>
References: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
 <6479e0c0-97fb-ca3b-1337-6ed11410d94f@samsung.com>
Message-ID: <d90b6245-1ed4-32c6-c98d-cc5f12601205@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On 05/25/2016 02:51 AM, Marek Szyprowski wrote:
> Hello,
> 
> 
> On 2016-05-24 19:41, Javier Martinez Canillas wrote:
>> This series fixes an imprecise external abort error when accessing the
>> Exynos MFC registers due the power domain configuration requiring the
>> aclk333 clock to be enabled during a domain switch.
>>
>> There isn't a dependency between the clock and Linux Samsung SoC trees
>> because the CLK_ACLK333 clock ID is already defined so the patches can
>> be picked indepedently by the relevant subsystem maintainers.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> I'm really curious what kind of async-bridge is there, but this patch
> really fixes the problem with mfc power domain.
>

Yes, the Exynos manual is not that clear about what clocks have to remain
enabled during a power domain switch for an IP block so maybe I got wrong.

I see that the MFC block has an async-bridge in "Figure 15-1" at section 
"15.2.1 NoC Probes in 5420 Bus". And I thought that since the IP block
has an async-bridge, the clock needs to remain ungated when the PMU turn
it on and off on a power domain switch.

I chose that clock because "Figure 7-10 MFC Clock Diagram" at section
"7.4.7 MFC Clock Diagram" shows that ACLK_333 is associated with the
MFC internal buses, or at least that's my understanding.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
