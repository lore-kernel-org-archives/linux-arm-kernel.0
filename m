From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Apr 2011 19:01:10 +0100
Subject: [PATCH 0/3] Export valuable System-on-Chip information to user-space
	via sysfs
Message-ID: <4DA341E6.70700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

This patch-set is based on Maxime Coquelin's <maxime.coquelin-nonst@stericsson.com> previous attempts. All advice has been taken and this is the resultant work. The main points taken into consideration are:
 * Ability to support multiple SoCs on any one device
 * Each SoC is registered as a _real_ device

Documentation/ABI/testing/sysfs-devices-soc |   16 +++++
 arch/arm/mach-ux500/Kconfig                 |    1 +
 arch/arm/mach-ux500/id.c                    |   96 +++++++++++++++++++++++++++
 drivers/base/Kconfig                        |    3 +
 drivers/base/Makefile                       |    1 +
 drivers/base/soc.c                          |   96 +++++++++++++++++++++++++++
 include/linux/sys_soc.h                     |   29 ++++++++
 7 files changed, 242 insertions(+), 0 deletions(-)
