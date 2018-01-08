From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 8 Jan 2018 15:33:26 +0800
Subject: [PATCH 0/2] pinctrl: meson: use one uniform 'function' name
Message-ID: <20180108073328.205769-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches are general improvement for meson pinctrl driver.
It make the two pinctrl trees (ee/ao) to share one uniform 'function' name for
one hardware block even its pin groups live inside two differet hardware domains,
which for example EE vs AO domain here.

This idea is motivated by Martin's question at [1]

[1]
 http://lkml.kernel.org/r/CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw at mail.gmail.com


Yixun Lan (2):
  pinctrl: meson: introduce a macro to have name/groups seperated
  pinctrl: meson-axg: correct the pin expansion of UART_AO_B

 drivers/pinctrl/meson/pinctrl-meson-axg.c | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson.h     | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.15.1
