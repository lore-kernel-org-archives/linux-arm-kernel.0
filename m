From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 11 Jul 2016 10:43:39 +0200
Subject: [PATCH v3]Add STM32F746 MCU pinctrl support
Message-ID: <1468226620-574-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds STM32F746 pinctrl and GPIO support, relies on the
generic STM32 pinctrl driver.

Changes since v2:

According to Linus remark, use builtin_platform_driver() instead of 
device_initcall() as there are nothing to do in driver init function
(except to register driver).

As soon this patch will be accepted, I will send the same update for 
stm32f429 pinctrl. 

Changes since v1:

Thanks to Paul Gortmaker remarks, remove all modular API as this driver is only
built-in one.

Regards

Alex

Alexandre TORGUE (1):
  pinctrl: Add STM32F746 MCU support

 drivers/pinctrl/stm32/Kconfig             |    6 +
 drivers/pinctrl/stm32/Makefile            |    2 +
 drivers/pinctrl/stm32/pinctrl-stm32f746.c | 1681 +++++++++++++++++++++++++++++
 3 files changed, 1689 insertions(+)
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f746.c

-- 
1.9.1
