From: zhi.mao@mediatek.com (Zhi Mao)
Date: Fri, 30 Jun 2017 14:05:15 +0800
Subject: [PATCH v3 0/6] mediatek: pwm driver add MT2712/MT7622 support 
Message-ID: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change in v3:
1. add pwm clk disable in function:mtk_pwm_config()
   for error parameter checking case

Zhi Mao (6):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix pwm source clock selection
  pwm: mediatek: fix clock control issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add PWM_CLK_DIV_MAX
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  133 ++++++++++++++------
 3 files changed, 104 insertions(+), 37 deletions(-)
