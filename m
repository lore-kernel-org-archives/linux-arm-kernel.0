From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jan 2013 11:05:45 +0100
Subject: [GIT PULL] MTU clksrc changes for v3.9
Message-ID: <CACRpkdaFLNWj4qg=571K5pCrE01r6JoSOGoUvGGBOCeEW=3hYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Hi, this is a pull request for stuff for the *next* merge window, enabling
the MTU timer to be used for timer-based delay.

Since there are some pending patches moving the ux500 cpufreq driver
around here:
http://marc.info/?l=linux-arm-kernel&m=135515323413100&w=2
it should be applied to the cpufreq tree to minimize conflicts.
Patches are ACKed by John Stultz.

Please pull it into the cpufreq tree or advise on alternate path, we can
also take this and the other cpufreq patches through the ARM SoC
tree if you ACK them.

Yours,
Linus Walleij


The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/clksrc-mtu-for-arm-soc

for you to fetch changes up to f644f2260aba851219e751a68ed2d37d6306fa0a:

  cpufreq: db8500: set CPUFREQ_CONST_LOOPS (2013-01-06 23:55:51 +0100)

----------------------------------------------------------------
- Implement timer-based delay on the Nomadik MTU
  clocksource
- Modify CPUFREQ to account for the same change.

----------------------------------------------------------------
Fabio Baltieri (2):
      clocksource: nomadik-mtu: support timer-based delay
      cpufreq: db8500: set CPUFREQ_CONST_LOOPS

 drivers/clocksource/nomadik-mtu.c | 11 +++++++++++
 drivers/cpufreq/db8500-cpufreq.c  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)
