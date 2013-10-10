From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 10 Oct 2013 18:26:13 -0400
Subject: [PATCH v3 0/5] Add some missing bits for exynos5250-snow
In-Reply-To: <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
References: <1380839303-4834-1-git-send-email-seanpaul@chromium.org>
Message-ID: <1381443978-5654-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set adds some missing devicetree nodes to the exynos5250-snow file as well
as adds a drm_bridge driver for the ptn3460 DP-LVDS chip. This chip is used in
the exynos5250-snow board.

Sean


Sean Paul (5):
 ARM: dts: Add fimd display-timings for exynos5250-snow
 ARM: dts: Add dp-controller node to exynos5250-snow
 drm/bridge: Add PTN3460 bridge driver
 drm/exynos: Initialize ptn3460 if present
 ARM: dts: Add ptn3460 to exynos5250-snow

 Documentation/devicetree/bindings/drm/bridge/ptn3460.txt |  27 ++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts                    |  50 ++++++++++++++++
 drivers/gpu/drm/Kconfig                                  |   2 ++
 drivers/gpu/drm/Makefile                                 |   1 +
 drivers/gpu/drm/bridge/Kconfig                           |   4 +++
 drivers/gpu/drm/bridge/Makefile                          |   3 ++
 drivers/gpu/drm/bridge/ptn3460.c                         | 349 ++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_core.c                 |  44 ++++++++++++++++
 include/drm/bridge/ptn3460.h                             |  37 ++++++++++++++++
