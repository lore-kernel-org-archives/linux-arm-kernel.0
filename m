From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu,  1 Dec 2016 18:15:13 +0100
Subject: [PATCH 0/3] ARM: da850: fix pll0 rate setting
Message-ID: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to set the pll0 rate from the kernel I noticed there are
two issues with da850 clocks. The first patch fixes an infinite loop
in propagate_rate(). The third fixes an oops in da850_set_pll0rate().
The second patch is just a coding style fix, while we're at it.

Bartosz Golaszewski (3):
  ARM: da850: fix infinite loop in clk_set_rate()
  ARM: da850: coding style fix
  ARM: da850: fix da850_set_pll0rate()

 arch/arm/mach-davinci/da850.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.9.3
