From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 13:37:38 +0900
Subject: [PATCH 0/4] hwrng: exynos - Add Device Tree support
Message-ID: <1445229462-32395-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patchset fixes known issues in Exynos hardware random number
generator and adds Device Tree support for it.

The device was tested on Trats2 board (Exynos4412). It should work
on other Exynos4 and Exynos5 as well... altough it seems that
on some of Exynos542x boards the SSS module is secured.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: rng: Describe Exynos4 PRNG bindings
  hwrng: exynos - Add timeout for waiting on init done
  hwrng: exynos - Fix missing configuration after suspend to RAM
  hwrng: exynos - Add Device Tree support

 .../bindings/rng/samsung,exynos-rng4.txt           | 17 +++++++
 drivers/char/hw_random/exynos-rng.c                | 56 ++++++++++++++++++----
 2 files changed, 65 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos-rng4.txt

-- 
1.9.1
