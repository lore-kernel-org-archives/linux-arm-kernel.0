From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:03:49 +0100
Subject: [PATCH v2 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
In-Reply-To: <20170311172527.16368-4-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-4-krzk@kernel.org>
 <CGME20170314130352epcas5p472cdaa4ae512b4a839d92e85d6dadb81@epcas5p4.samsung.com>
Message-ID: <6788694.7QfyuOlrPv@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, March 11, 2017 07:25:22 PM Krzysztof Kozlowski wrote:
> The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
> Just like the others, for working it requires additional steps in Power
> Management Unit: unmasking the reset request and enabling the system
> reset.  Without these additional steps in PMU, the watchdog will not be
> able to reset the system on expiration event.
> 
> Change the compatible of Exynos4412 watchdog device node to
> samsung,exynos5250-wdt which includes the additional PMU steps.

This is going to confuse people.  How's about doing it cleanly
(by adding samsung,exynos4412-wdt compatible and convert existing
users to use instead)?

> This will also fix infinite watchdog interrupt in soft mode (lack of
> interrupt clear) because it is also included in samsung,exynos5250-wdt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
