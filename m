From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue,  3 May 2016 16:27:15 -0400
Subject: [PATCH 0/3] [media] s5p-mfc: Fixes for issues when module is removed
Message-ID: <1462307238-21815-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes some issues that I noticed when trying to remove
the s5p-mfc driver when built as a module.

Some of these issues will be fixed once Marek's patches to convert the
custom memory region reservation code is replaced by a generic one that
supports named memory region reservation [0]. But the fixes are trivial
so we can fix the current code until his rework patch lands.

[0]: https://patchwork.linuxtv.org/patch/32287/

Best regards,
Javier


Javier Martinez Canillas (3):
  [media] s5p-mfc: Set device name for reserved memory region devs
  [media] s5p-mfc: Add release callback for memory region devs
  [media] s5p-mfc: Fix race between s5p_mfc_probe() and s5p_mfc_open()

 drivers/media/platform/s5p-mfc/s5p_mfc.c | 50 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

-- 
2.5.5
