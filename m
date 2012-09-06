From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 06 Sep 2012 14:52:59 +0530
Subject: [PATCH 0/2] i2c: s3c2410: allow pin pin configuration using pinctrl
Message-ID: <1346923381-14144-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for pinctrl interface based i2c-bus
configuration for the s3c2410 i2c controller driver.

The second patch would have conflict with Exynos4 DTS reorganization
patches posted by Tomasz Figa. If those patches are applied prior to this
patch, I will rebase this patch and resubmit.

Thomas Abraham (2):
  i2c: s3c2410: add optional pin configuration using pinctrl interface
  ARM: dts: exynos4: allow i2c0 bus to be configured using pinctrl interface

 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 --
 arch/arm/boot/dts/exynos4210.dtsi         |    2 ++
 drivers/i2c/busses/i2c-s3c2410.c          |   19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 5 deletions(-)
