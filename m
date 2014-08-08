From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Fri,  8 Aug 2014 15:28:47 +0800
Subject: [PATCH v5 0/2] This series adds support for RK3288 SoC integrated PWM
Message-ID: <1407482929-13050-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will make applying on the top of Beniamino's submission,
the Beniamino's submission come from [1].

[1]:
    https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-next

    Beniamino's submission won't be used from genenation Rockchip SoCs.
    So I have to add the new pwm for next genenation Rockchip SoCs.

    Tested on RK3288 SDK board.

Changes in v5:
    * address comments from Thierry Reding and Doug Anderson:
    - fix the symbolic names for registers. 

Changes in v4:
    * address comments from Heiko St?bner:
    - fix the copyright for ROCKCHIP, Inc. 
    - remove rockchip_pwm_set_enable_vop,then it instead of rockchip_pwm_set_enable_v2.

Changes in v3:
    * address comments from Thierry Reding:
    - fix PWM document deccribes. 
    - add a description for [PATCH v3 2/2].
    - renamed the PWM registers
    - Changed in rockchip_pwm_data struct
    - remove the devm_ioremap(),fixed in lcdc driver.

Changes in v2:
    * address comments from Beniamino Galvani:
    - remove #include <linux/of_address.h>. 
    - of_iomap be removed,and devm_ioremap replace it.
    - remove a line no be used.

Caesar Wang (2):
  pwm: rockchip: document RK3288 SoC compatible
  pwm: rockchip: Added to support for RK3288 SoC

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   5 +-
 drivers/pwm/pwm-rockchip.c                         | 134 +++++++++++++++++----
 2 files changed, 114 insertions(+), 25 deletions(-)

-- 
1.9.1
