From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:08 +0400
Subject: [PATCH 0/6] arm: sa1100: refactor h3xxx GPIO handling
Message-ID: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

I have been thinking abbout h3100/h3600 and GPIO issues.Could you please
review and test these patches. It is an attempt to cleanup and refactor GPIO
handling not to call gpio_request at init_machine time.

  git://github.com/lumag/linux h3xxx-gpios

for you to fetch changes up to c9027b88b6e79556599ca625d2c674704985474a:

  arm: sa1100: h3xxx: drop hand-coded gpio_request_array analogue (2013-11-21 01:51:02 +0400)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (6):
      arm: sa1100: h3100: refactor LCD GPIO handling
      arm: sa1100: h3600: refactor LCD GPIO handling
      arm: sa1100: h3100: refactor IrDA GPIO handling
      arm: sa1100: h3600: refactor IrDA GPIO handling
      arm: sa1100: h3xxx: move serial port GPIO handling to common place
      arm: sa1100: h3xxx: drop hand-coded gpio_request_array analogue

 arch/arm/mach-sa1100/h3100.c              | 61 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 arch/arm/mach-sa1100/h3600.c              | 81 +++++++++++++++++++++++++++++++++------------------------------------------------
 arch/arm/mach-sa1100/h3xxx.c              | 58 +++++++++++++++++++++++++++-------------------------------
 arch/arm/mach-sa1100/include/mach/h3xxx.h | 11 -----------
 4 files changed, 104 insertions(+), 107 deletions(-)
