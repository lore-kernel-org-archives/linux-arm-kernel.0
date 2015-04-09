From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 Apr 2015 17:01:45 +0800
Subject: [PATCH v2 0/3] media: atmel-isi: rework on the clock part and add
 runtime pm support
Message-ID: <1428570108-4961-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fix the peripheral clock code and enable runtime pm
support.
Also it clean up the code which is for the compatiblity of mck.

Changes in v2:
- merged v1 two patch into one.
- use runtime_pm_put() instead of runtime_pm_put_sync()
- enable peripheral clock before access ISI registers.
- totally remove clock_start()/clock_stop() as they are optional.

Josh Wu (3):
  media: atmel-isi: remove the useless code which disable isi
  media: atmel-isi: add runtime pm support
  media: atmel-isi: remove mck back compatiable code as it's not need

 drivers/media/platform/soc_camera/atmel-isi.c | 101 ++++++++++++--------------
 1 file changed, 45 insertions(+), 56 deletions(-)

-- 
1.9.1
