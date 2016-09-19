From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 19 Sep 2016 16:43:59 +0800
Subject: [PATCH 0/1] fix rk3066a based boards boot issue on linux-4.8
Message-ID: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, heiko:
   I found my Rayeager board couldn't boot up on linux 4.8. After some
dig, I found the pwm-regulator for vdd_log register failed and found
some change in Boris's patch: commit 87248991a1de(regulator: pwm: Properly
initialize the ->state field).
   I send this patch to make the pwm-regulator can register success on
this change.


Andy Yan (1):
  arm: dts: fix rk3066a based boards vdd_log voltage initialization

 arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
