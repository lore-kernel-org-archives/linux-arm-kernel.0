From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:05:16 +0200
Subject: [PATCH 00/24] ste_dma40: Fine-tuning for several function
 implementations
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Message-ID: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:56:56 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (24):
  Use kmalloc_array() in d40_lcla_allocate()
  Return directly after a failed kmalloc_array()
  Rename a jump label in d40_lcla_allocate()
  Move an assignment in d40_lcla_allocate()
  Improve a size determination in d40_of_probe()
  Replace four kzalloc() calls by kcalloc() in d40_hw_detect_init()
  Use kmalloc_array() in d40_hw_detect_init()
  Less checks in d40_hw_detect_init() after error detection
  Delete unnecessary variable initialisations in d40_hw_detect_init()
  Adjust the position of a jump label in d40_probe()
  Rename a jump label in d40_probe()
  Rename jump labels in d40_dmaengine_init()
  Rename a jump label in d40_alloc_chan_resources()
  One check less in d40_prep_sg() after error detection
  Move two assignments in d40_prep_sg()
  Rename a jump label in d40_prep_desc()
  Move an assignment in d40_prep_desc()
  Rename a jump label in d40_is_paused()
  Rename a jump label in d40_free_dma()
  Rename a jump label in d40_alloc_mask_free()
  Rename jump labels in d40_alloc_mask_set()
  Rename a jump label in dma_tasklet()
  Rename a jump label in __d40_execute_command_phy()
  Rename a jump label in d40_log_lli_to_lcxa()

 drivers/dma/ste_dma40.c | 253 +++++++++++++++++++++++-------------------------
 1 file changed, 122 insertions(+), 131 deletions(-)

-- 
2.10.0
