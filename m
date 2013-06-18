From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 11:07:25 -0700
Subject: [GIT PULL 2/7] omap serial pm cleanup for v3.11 merge window
In-Reply-To: <pull-1371578847-800598>
Message-ID: <mailman.8.1371578935.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-serial-signed

for you to fetch changes up to 1e383d7bdd988b1453a3a86f5e14b012700f7dff:

  Merge tag 'omap-pm-v3.11/cleanup/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm-serial (2013-06-17 04:03:14 -0700)

----------------------------------------------------------------

Serial driver platform init code clean-up via Kevin Hilman <khilman@linaro.org>:

OMAP: PM: the serial core + driver can no handle no_console_suspend support
without any SoC specific handlding or SoC-specific DT bindings.  Remove
the now unused SoC specifics for OMAP.

----------------------------------------------------------------
Sourav Poddar (3):
      arm: omap2+: serial: remove no_console_suspend support
      arm: dts: am33xx: Remove "ti,no_idle_on_suspend" property.
      arm: omap2+: omap_device: remove no_idle_on_suspend

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.11/cleanup/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.11/pm-serial

 arch/arm/boot/dts/am33xx.dtsi     |  1 -
 arch/arm/mach-omap2/omap_device.c |  9 ++-------
 arch/arm/mach-omap2/omap_device.h | 10 ----------
 arch/arm/mach-omap2/serial.c      |  7 -------
 4 files changed, 2 insertions(+), 25 deletions(-)
