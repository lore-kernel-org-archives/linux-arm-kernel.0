From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Oct 2017 17:12:32 +0200
Subject: [PATCH v2 0/3] mtd: spi-nor: stm32-quadspi: fixes
Message-ID: <1509030755-19044-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This series adds:
-Fix: to avoid compilation warning with older compiler
versions such as gcc-4.6.
This topic has been discussed on 2 threads with Geert and Arnd
https://lkml.org/lkml/2017/9/15/70
https://www.spinics.net/lists/arm-kernel/msg606269.html
-Fix: abort prefetching in memory-mapped mode as soon prefetching
could exceed nor size (not done by fsize limit)
-Change license text and Copyright

Changes v2:
with the right Cyrille's email (wedev4u.fr)

Geert Uytterhoeven (1):
  mtd: spi-nor: stm32-quadspi: Fix uninitialized error return code

Ludovic Barre (2):
  mtd: spi-nor: stm32-quadspi: fix prefetching outside fsize
  mtd: spi-nor: stm32-quadspi: change license text

 drivers/mtd/spi-nor/stm32-quadspi.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

-- 
2.7.4
