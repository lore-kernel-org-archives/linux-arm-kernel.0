From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 21:08:05 +0200
Subject: [PATCH 0/2] clk: ARM: dts: exynos: Fix hang on Odroid U3
Message-ID: <20170621190807.14850-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent linux-next fails to boot on Odroid U3 (Exynos4412) because
of commit 6edfa11cb396 ("clk: samsung: Add enable/disable operation
for PLL36XX clocks").

Patchset fixes it. Patches are independent although both are required
to fix the issue.

I will be taking DTS change.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  clk: samsung: audss: Fix silent hang on Exynos4412 due to disabled
    EPLL
  ARM: dts: exynos: Add clocks to audss block to fix silent hang on
    Exynos4412

 arch/arm/boot/dts/exynos4.dtsi         | 3 +++
 drivers/clk/samsung/clk-exynos-audss.c | 1 +
 2 files changed, 4 insertions(+)

-- 
2.9.3
