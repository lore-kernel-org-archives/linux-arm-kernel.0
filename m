From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 15:57:30 +0200
Subject: [PATCH 0/2] ASoC: stm32: add SPDIFRX driver
Message-ID: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set handles the SPDIFRX on STM32 platforms.

The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
IEC-60958 and IEC-61937 standards.

SPDIFRX uses two DMA channels:
- one DMA channel for S/PDIF data stream.
- one DMA channel for control flow (channel status and user data bits).

DMA is used for control flow instead of interrupts to get better performances,
as channel status and user data are retrieved byte per byte.

Note: This patch-set depends on "change SAI configuration flag" patch,
which introduces a change on Kconfig file.

olivier moysan (2):
  dt-bindings: Document the STM32 SPDIFRX interface
  ASoC: stm32: Add SPDIFRX support

 .../devicetree/bindings/sound/st,stm32-spdifrx.txt |  56 ++
 sound/soc/stm/Kconfig                              |  10 +
 sound/soc/stm/Makefile                             |   4 +
 sound/soc/stm/stm32_spdifrx.c                      | 998 +++++++++++++++++++++
 sound/soc/stm/stm32_spdifrx.h                      | 224 +++++
 5 files changed, 1292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
 create mode 100644 sound/soc/stm/stm32_spdifrx.c
 create mode 100644 sound/soc/stm/stm32_spdifrx.h

-- 
1.9.1
