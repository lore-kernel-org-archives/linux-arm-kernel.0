From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 25 Jan 2011 23:07:36 +0530
Subject: [PATCH 0/5] OMAP3EVM: Board bug fixes/enhancements
Message-ID: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current linux-omap/master is broken for lots of features/modules
and also there are few enhancements required with addition of AM/DM37x
family of devices.

	- Migrate TWL gpio_xxx api to gpio_xx_cansleep
	- TSC: Driver init fails due to missing VIO regulator
	- TSC: Wakeup is broken, enable the wakeup capability
	- DSS: Addition of Mux changes for AM/DM37x
	- Make Backlight gpio off in default state

Note: Resetting the revision of patches since this is first bundled series.

Vaibhav Hiremath (5):
  OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
  OMAP3EVM: Add vio regulator supply required for ads7846 TSC driver
  AM/DM37x: DSS mux configuration for >Rev-B processor cards
  OMAP3EVM: Made backlight GPIO default state to off
  OMAP3EVM: Set TSC wakeup option in pad config

 arch/arm/mach-omap2/board-omap3evm.c |   80 +++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 11 deletions(-)
