From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 18:05:16 +0100
Subject: [PATCH 0/5] hwrng: stm32 - Improvement for stm32-rng 
Message-ID: <20180129170521.1862-1-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches add extended functionalities for stm32 rng
driver.
Patch #1 includes a reset during probe to avoid any error status
which can occur during bootup process and keep safe rng integrity.

Patch #3 adds a new property to manage the clock error detection
feature which can be disabled on specific target.

Patch #5 rework the timeout calculation for read value that was
previously defined based on loop operation and is now based on
timer.

Lionel Debieve (5):
  hwrng: stm32 - add reset during probe
  dt-bindings: rng: add reset node for stm32
  hwrng: stm32 - allow disable clock error detection
  dt-bindings: rng: add clock detection error for stm32
  hwrng: stm32 - rework read timeout calculation

 .../devicetree/bindings/rng/st,stm32-rng.txt       |  4 ++
 drivers/char/hw_random/stm32-rng.c                 | 44 ++++++++++++++--------
 2 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.15.1
