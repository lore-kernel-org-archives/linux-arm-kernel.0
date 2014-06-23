From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Jun 2014 15:23:46 -0600
Subject: [GIT PULL 3/3] ARM: tegra: use us counter as delay timer
In-Reply-To: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1403558626-13422-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra has a micro-second counter whose rate doesn't vary with cpufreq
changes. Register it so it can be used as the delay timer, so delays
aren't influenced by cpufreq.

I've made this a separate branch since it touches a few files outside
arch/arm/mach-tegra/. This can be merged anywhere that conflicts need
to be resolved, although I know of no such places at present.

----------------------------------------------------------------

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.17-delay-timer

for you to fetch changes up to 0ff36b4f479ec8e0cd9b7a919ab877f2d553cd30:

  clocksource: tegra: Use us counter as delay timer

----------------------------------------------------------------

Peter De Schrijver (3):
      kernel: add calibration_delay_done()
      ARM: choose highest resolution delay timer
      clocksource: tegra: Use us counter as delay timer

 arch/arm/lib/delay.c                | 26 ++++++++++++++++++++++----
 drivers/clocksource/tegra20_timer.c | 13 +++++++++++++
 init/calibrate.c                    | 11 +++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)
