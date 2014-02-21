From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Feb 2014 17:25:04 +0100
Subject: [PATCH v2 2/2] phy: Select PHY_EXYNOS_DP_VIDEO by default for
 ARCH_EXYNOS
In-Reply-To: <1753680.KKj0Q1erxA@wuerfel>
References: <1392997802-29050-1-git-send-email-s.nawrocki@samsung.com>
 <1392997802-29050-2-git-send-email-s.nawrocki@samsung.com>
 <1753680.KKj0Q1erxA@wuerfel>
Message-ID: <53077DE0.7080108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/14 16:59, Arnd Bergmann wrote:
> On Friday 21 February 2014 16:50:02 Sylwester Nawrocki wrote:
>>  config PHY_EXYNOS_DP_VIDEO
>>         tristate "EXYNOS SoC series Display Port PHY driver"
>>         depends on OF
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>> +       default y
>>         select GENERIC_PHY
>>         help
>>
> 
> That would turn them on automatically if you enable COMPILE_TEST, which
> is probably not what you want.
> 
> How about "default ARCH_EXYNOS"?

Hmm, good point, I will modify it that way.

For patch 1/2 I guess it should be:

"default ARCH_S5PV210 || ARCH_EXYNOS"

or rather

"default y if ARCH_S5PV210 || ARCH_EXYNOS" ?

Thanks,
Sylwester
