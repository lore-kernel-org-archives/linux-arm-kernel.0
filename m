From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 05 Dec 2014 13:04:36 +0100
Subject: [GIT PULL] samsung clk cleanups and fixes for v3.19
Message-ID: <54819F54.1060705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mike,

This includes a few bug fix and cleanup patches for clk/samsung.
Please pull for 3.19 if it looks OK.

The following changes since commit 2e41b9fc11f2d242f39b36ceba833471629ba3d5:

  clk: samsung: Spelling s/bwtween/between/ (2014-12-02 12:28:20 +0100)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/for-v3.19-exynos-clk-2

for you to fetch changes up to c31844ffdbd4e73a16c66e9d7df8ec290ab4b159:

  clk: samsung: Fix double add of syscore ops after driver rebind (2014-12-02
16:22:59 +0100)

----------------------------------------------------------------
- exynos4415 and exynos audio subsystem clk driver (build
  with PM_SLEEP disabled, resource release) fixes
- minor cleanups in drivers/clk/samsung/clk.c (spelling,
  includes)
- modification of the exynos4 HDMI PHY clock definition to
  model dependency of "sclk_hdmiphy" on the "hdmi" clock

----------------------------------------------------------------
Andrzej Hajda (1):
      clk: samsung: exynos4: set parent of sclk_hdmiphy to hdmi

Krzysztof Kozlowski (2):
      clk: samsung: exynos4415: Fix build with PM_SLEEP disabled
      clk: samsung: Fix double add of syscore ops after driver rebind

Pankaj Dubey (2):
      clk: samsung: remove unnecessary CONFIG_OF from clk.c
      clk: samsung: remove unnecessary inclusion of header files from clk.h

 drivers/clk/samsung/clk-exynos-audss.c |    4 ++++
 drivers/clk/samsung/clk-exynos4.c      |    2 +-
 drivers/clk/samsung/clk-exynos4415.c   |    6 ++++--
 drivers/clk/samsung/clk.c              |    4 ++--
 drivers/clk/samsung/clk.h              |    4 ----
 5 files changed, 11 insertions(+), 9 deletions(-)

--
Thanks,
Sylwester
