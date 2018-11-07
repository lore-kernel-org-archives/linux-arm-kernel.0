From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 7 Nov 2018 10:30:39 +0100
Subject: [PATCH V2 0/2] mmc: mmci: add stop command
Message-ID: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series sends a stop command:
-If set block count command fail, the host
needs to issue cmd12 if any error is detected in
the CMD18 and CMD25 operations.
-On stm32 sdmmc variant, if a request fail
the DPSM must be cleared by a stop command.

Ludovic Barre (2):
  mmc: mmci: send stop command if sbc error issue
  mmc: mmci: add variant property to send stop cmd if a command fail

 drivers/mmc/host/mmci.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/mmci.h |  4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.7.4
