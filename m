From: lionel.Debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 15:28:08 +0100
Subject: [PATCH 0/3] crypto: stm32/hash: Correction to improve robustness
Message-ID: <20180129142811.13273-1-lionel.Debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lionel Debieve <lionel.debieve@st.com>

Hi,

This patch serie will improve global robustness for stm32-hash driver. 

Patch #1 is fixing dma-burst issue when configuration is not set.
Patch #2 solves issue that occurs when irq append during final req processing.
Patch #3 is fixing an issue that have been introduced while managing padding but
breaking the padding length calculation by hardware to generate correct hash.

Regards,

Lionel Debieve (3):
  crypto: stm32/hash: avoid error if maxburst not defined
  crypto: stm32/hash: fix performance issues
  crypto: stm32/hash: rework padding length

 drivers/crypto/stm32/stm32-hash.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.15.1
