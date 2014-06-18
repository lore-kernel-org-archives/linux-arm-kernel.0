From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 18 Jun 2014 18:22:29 +0200
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2, U3 board
Message-ID: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic sound support for the Odroid X2/U3 boards.
It relies on specific Exynos Audio Subsystem clock parent and
frequencies being pre-configured.

My full testing git branch has been pushed to:
git://linuxtv.org/snawrocki/samsung.git v3.16-rc1-odroid-sound-clk

It can be browsed at:
http://git.linuxtv.org/cgit.cgi/snawrocki/samsung.git/log/?h=v3.16-rc1-odroid-sound-clk

I didn't use the simple-card since there is going to be added
one more CPU interface using the secondary I2S and IDMA.

Sylwester Nawrocki (2):
  ASoC: samsung: Add machine driver for Odroid X2/U3
  doc: dt bindings: Document Odroid X2/U3 audio subsystem bindings

 .../bindings/sound/samsung,odroidx2-max98090.txt   |   35 ++++
 sound/soc/samsung/Kconfig                          |    8 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/odroidx2_max98090.c              |  191 ++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroidx2-max98090.txt
 create mode 100644 sound/soc/samsung/odroidx2_max98090.c

--
1.7.9.5
