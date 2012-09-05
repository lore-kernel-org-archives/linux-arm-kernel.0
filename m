From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Sep 2012 10:20:28 +0200
Subject: [GIT PULL] ks8695 timer changes for v3.7
Message-ID: <CACRpkdbKJU9gp2MLKZQTGiyysoM38owyxJx8S2zFzRJiv61c5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof:

Here is that patch series that switches KS8695 over to using generic
time and clockevents. Signed tag provided.

All tested by Greg Ungerer.

Please pull it in!

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ks8695-time-for-arm-soc

for you to fetch changes up to c7e783d6adc7798307e7063e11f4127117446d5a:

  ARM: ks8695: convert to generic time and clocksource (2012-09-05
08:49:22 +0200)

----------------------------------------------------------------
This cleans up the ks8695 timer driver and converts
it to use generic time and clock events.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: ks8695: merge the timer header into the timer driver
      ARM: ks8695: use [readl|writel]_relaxed()
      ARM: ks8695: delete resume hook from timer
      ARM: ks8695: convert to generic time and clocksource

 arch/arm/Kconfig                               |   3 +-
 arch/arm/mach-ks8695/include/mach/regs-timer.h |  40 --------
 arch/arm/mach-ks8695/time.c                    | 133 +++++++++++++++++--------
 3 files changed, 92 insertions(+), 84 deletions(-)
 delete mode 100644 arch/arm/mach-ks8695/include/mach/regs-timer.h
