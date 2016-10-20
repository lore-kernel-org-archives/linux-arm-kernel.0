From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 15:26:50 +0200
Subject: [PATCH 0/2] STM32 pinctrl: remove dependency between pinctrl driver
 and device tree
Message-ID: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

Currently 4.9-rc1 is not booting correctly on STM32F4. 
By adding gpios irqs support to stm32 pinctrl, a dependency has been 
added between pinctrl stm32 and stm32f4 device tree (my mistake). 
This series breaks this dependency and has to be taken on 4.9_rcs. 

Regards
Alex


Alexandre TORGUE (2):
  pinctrl: stm32: remove dependency with interrupt controller
  pinctrl: stm32: move gpio irqs binding to optional

 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 10 +++++-----
 drivers/pinctrl/stm32/pinctrl-stm32.c                          |  8 +++++---
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.9.1
