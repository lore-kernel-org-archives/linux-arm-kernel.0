From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 14 Nov 2015 20:24:20 +0900
Subject: [PATCH v5 0/9] samsung: pmu: split up SoC specific PMU data
In-Reply-To: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <564719E4.1030104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 13.11.2015 o 18:29, Pankaj Dubey pisze:
> This patch series is a part of continuation work from following series
> [1], [2], [3] and [4]
> 
> 1: exynos: Move pmu driver to driver/soc folder and add exynos7 support
>    http://www.spinics.net/lists/linux-samsung-soc/msg39797.html from Amit Daniel Kacchap
> 2: soc: samsung: pmu: split up SoC specific PMU data
>    https://lkml.org/lkml/2015/1/7/12 from me
> 3: https://lkml.org/lkml/2015/10/26/245
> 4: https://lkml.org/lkml/2015/11/10/180
> 
> In this series I am splitting up SoC specific PMU configuration data into
> mach-exynos folder itself, before moving all of them under
> drivers/soc/samsung/. Also instead of making all changes in single patch it
> has been broken into SoC specific patches to avoid large size of patch.
> With this approach there will not be unwanted big churns just after
> adding exynos-pmu under drivers/soc/samsung.
> 
> All these patches are just refactoring to keep minimal changes while moving
> exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can
> be added on top of it, in such a manner that for ARM64 build, ARM related
> SoC's PMU will not get compiled and thus unnecessary increasing kernel image size.
> 
> I have tested on Peach-Pi (Exynos5880) based chromebook for boot
> and S2R functionality.
> 


Entire patchset tested on Trats2 (Exynos4412, S2R, reboot, poweroff) and
Odroid XU3 (Exynos5422, reboot, poweroff).

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
