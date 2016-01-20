From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 20 Jan 2016 10:45:30 +0000
Subject: [PATCH v1 0/3] mmc: pwrseq: convert to proper driver
Message-ID: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, 

This patchset aims at converting the pwrseq devices to proper in built drivers,
The issue is that on Qualcomm based platforms, most of the gpios require
a pinctrl setup. Existing pwrseq code does not do any kind of pinctrl setup.
So this makes the pwrseq unusable on those platfroms.

Convert the pwrseq to proper drivers so that they can reuse
common driver setup like pinctrl from drivers/base/pinctrl.c
This solution works much better and would make pwrseq to reuse 
all the driver setup done in the common code.


Changes since RFC:
	- Fixed issues reported by kbuild test robot.
	- return EPROBE_DEFER from *_alloc() suggested by Ulf.

Thanks,
srini

Srinivas Kandagatla (3):
  mmc: pwrseq_simple: add to_pwrseq_simple() macro
  mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
  mmc: pwrseq: convert to proper platform device

 drivers/mmc/core/pwrseq.c        | 112 +++++++++++++++++++++------------------
 drivers/mmc/core/pwrseq.h        |  13 +++--
 drivers/mmc/core/pwrseq_emmc.c   |  74 ++++++++++++++++----------
 drivers/mmc/core/pwrseq_simple.c |  86 ++++++++++++++++++------------
 4 files changed, 168 insertions(+), 117 deletions(-)

-- 
1.9.1
