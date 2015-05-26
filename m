From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 26 May 2015 16:00:08 +0800
Subject: [PATCH v4 0/2] media: atmel-isi: rework on the clock part and add
 runtime pm support
Message-ID: <1432627211-4338-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fix the peripheral clock code and enable runtime pm
support.
Also it clean up the code which is for the compatiblity of mck.

Changes in v4:
- need to call pm_runtime_disable() in atmel_isi_remove().
- merged the patch which remove isi disable code in atmel_isi_probe() as
  isi peripherial clock is not enabled in this moment.
- refine the commit log

Changes in v3:
- remove useless definition: ISI_DEFAULT_MCLK_FREQ
- remove some isi disable code if peripheral clock is disabled.

Changes in v2:
- merged v1 two patch into one.
- use runtime_pm_put() instead of runtime_pm_put_sync()
- enable peripheral clock before access ISI registers.
- totally remove clock_start()/clock_stop() as they are optional.

Josh Wu (2):
  media: atmel-isi: add runtime pm support
  media: atmel-isi: remove mck back compatiable code as it's not need

 drivers/media/platform/soc_camera/atmel-isi.c | 100 ++++++++++++--------------
 1 file changed, 46 insertions(+), 54 deletions(-)

-- 
1.9.1
