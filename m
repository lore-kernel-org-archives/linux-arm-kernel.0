From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Sep 2016 14:39:01 +0200
Subject: [PATCH v2 0/2] add support for the SDIO pins on GXBB
In-Reply-To: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the pins for the SDIO controller (sd_emmc_a) found on
Meson GXBB SoCs.

Changes since v1:
- add the missing SDIO interrupt pin:
  The initial pinctrl patch was already applied to linux-pinctrl's
  for-next branch, so patch 1 applies on top of the already existing
  patch (both can be squashed if needed).
  The dts patch was not applied anywhere yet, so patch 2 contains a
  fixed version of the patch (provided by Neil Armstrong - thanks!).


Martin Blumenstingl (1):
  pinctrl: meson-gxbb: add the missing SDIO interrupt pin

Neil Armstrong (1):
  ARM64: dts: meson-gxbb: add the SDIO pins

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 19 +++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  |  4 +++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.9.3
