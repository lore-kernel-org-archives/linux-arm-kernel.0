From: majun258@huawei.com (MaJun)
Date: Wed, 23 Mar 2016 17:06:31 +0800
Subject: [PATCH 0/2] Change the the config option of mbigen driver.
Message-ID: <1458723993-21044-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

In current driver, the config of mbigen driver is a configurable option and
have nothing to do with CONFIG_ARCH_HISI.

As a module of Hisilicon SOC, the config of mbigen driver should be selected
by CONFIG_ARCH_HISI on Hisilicon platform, but not a configurable option.

This patch set is applied to fix this problem.

Ma Jun (2):
  ARM64: Enable mbigen interrupt controller on Hisilicon platform
  irqchip/mbigen:Change the config option of mbigen driver to non-configurable

 arch/arm64/Kconfig.platforms |    1 +
 drivers/irqchip/Kconfig      |   14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)
