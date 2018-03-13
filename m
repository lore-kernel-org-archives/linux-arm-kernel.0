From: olivier.moysan@st.com (Olivier Moysan)
Date: Tue, 13 Mar 2018 17:27:05 +0100
Subject: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Message-ID: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support of iec958 controls to STM32 SAI driver.

The patch makes use of iec958 control status helpers previously proposed
and discussed through the following threads:
https://patchwork.kernel.org/patch/8062601/
https://patchwork.kernel.org/patch/8091551/ (v2)
https://patchwork.kernel.org/patch/8462961/ (v3)
https://patchwork.kernel.org/patch/8533731/ (v4)

Olivier Moysan (3):
  ALSA: pcm: add IEC958 channel status control helper
  ASoC: stm32: sai: add iec958 controls support
  ASoC: dmaengine_pcm: document process callback

 include/sound/dmaengine_pcm.h |   2 +
 include/sound/pcm_iec958.h    |  19 +++++++
 sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
 5 files changed, 225 insertions(+), 12 deletions(-)

-- 
1.9.1
