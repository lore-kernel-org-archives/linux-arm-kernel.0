From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 12 Jul 2017 08:11:48 +0900
Subject: [PATCH 0/2] gpio: select IRQ_DOMAIN_HIERARCHY fixing curcular Kconfig
 dependency
Message-ID: <1499814710-16686-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1/2 touches pinctrl driver, but
I want both patches in GPIO tree
because 1/2 is a prerequisite for 2/2.

Otherwise, Kconfig reports recursive dependency.

I noticed this problem when I added "select IRQ_DOMAIN_HIERARCHY"
to my GPIO driver, which I will submit later.

Please apply 1/2 to GPIO tree, not pinctrl tree.



Masahiro Yamada (2):
  pinctrl: stm32: select IRQ_DOMAIN_HIERARCHY instead of depends on
  gpio: xgene-sb: select IRQ_DOMAIN_HIERARCHY

 drivers/gpio/Kconfig          | 1 +
 drivers/pinctrl/stm32/Kconfig | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.7.4
