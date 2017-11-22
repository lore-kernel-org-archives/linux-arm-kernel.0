From: olivier.moysan@st.com (Olivier Moysan)
Date: Wed, 22 Nov 2017 16:02:24 +0100
Subject: [PATCH 0/3] ASoC: stm32: sai: fixes related to synchro feature
Message-ID: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sai binding and simplify code related to synchro feature.
This change allows to remove stm32_sai_remove() function
and use devm_of_platform_populate().

Olivier Moysan (3):
  ASoC: stm32: fix sync property description in SAI bindings
  ASoC: stm32: sai: simplify sync modes management
  ASoC: stm32: sai: use devm_of_platform_populate()

 .../devicetree/bindings/sound/st,stm32-sai.txt     |  12 ++-
 sound/soc/stm/stm32_sai.c                          | 114 ++++-----------------
 2 files changed, 29 insertions(+), 97 deletions(-)

-- 
1.9.1
