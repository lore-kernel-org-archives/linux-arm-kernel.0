From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 13 Apr 2018 15:52:11 +0200
Subject: [PATCH v3 0/2] Append some fixes and improvements
Message-ID: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix an issue with FIFO Size and burst size.
Fix an incomplete allocator for Hardware descriptors: memory badly
allocated.
---
  Version history:
    v1:
       * Initial
    v2:
       * Fix kbuild warning format: /0x%08x/%pad/
    v3:
       * Get rid of while loop in favor of computed values
       * use of "offsetof" instead of explicit calculation
---

Pierre-Yves MORDRET (2):
  dmaengine: stm32-mdma: align TLEN and buffer length on burst
  dmaengine: stm32-mdma: Fix incomplete Hw descriptors allocator

 drivers/dma/stm32-mdma.c | 98 ++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 40 deletions(-)

-- 
2.7.4
