From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 14:00:34 +0900
Subject: [PATCH 3/3] ARM: dts: Enable PRNG module on exynos4412-trats2
In-Reply-To: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
References: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1445230834-32689-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Pseudo Random Number Generator (PRNG) on Trats2 board. This
allows using hardware random number generator:
$ echo exynos > /sys/class/misc/hw_random/rng_current

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 40a474c4374b..a6f78c3da935 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1234,6 +1234,10 @@
 	status = "okay";
 };
 
+&prng {
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
-- 
1.9.1
