From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 18:01:27 +0900
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <19309272.tlWX2xvTnx@wuerfel>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <1424755011-15999-3-git-send-email-cw00.choi@samsung.com>
 <19309272.tlWX2xvTnx@wuerfel>
Message-ID: <54EC3DE7.7070306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 05:33 PM, Arnd Bergmann wrote:
> On Tuesday 24 February 2015 14:16:45 Chanwoo Choi wrote:
>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
>> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
>> PSCI (Power State Coordination Interface) v0.1.
>>
>> This patch includes following dt node to support Exynos5433 SoC:
>> 1. Octa core for big.LITTLE architecture
>> - Cortex-A53 LITTLE Quad-core
>> - Cortex-A57 big Quad-core
>> - Support PSCI v0.1
> 
> Should we try to come up with a way to better share parts of this with the
> exynos5 dtsi files you already have in arm32? I suspect that there is a
> significant overlap.

Currently, 32-bit Exynos5 SoC (which is included in arch/arm/boot/dts)
didn't support the Cortex-A53/A57 and PSCI.

The 32-bit Exynos5 SoC support the Coretex-A7 or A15 and big.LITTLE Exynos5 SoC
use the MCPM (Multi-Cluster PM) driver for secondary cpu on/off instead of PSCI.

Thanks,
Chanwoo Choi
