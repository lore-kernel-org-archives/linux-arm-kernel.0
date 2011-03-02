From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 02 Mar 2011 19:45:12 +0100
Subject: [patch v2 0/2] Get watchdog reboot working on efika smartbook
Message-ID: <20110302184512.512010086@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

With current patches in Sascha Hauer's tree, the efika smartbook is powering
off when rebooting. The cause of this bug is the default behaviour of the
mc13892 pmic. This patchset allows to configure the mc13892 to reboot the
system as expected by imx system.c throught platform_data and enables the
watchdog on the efika mx/sb systems.

Arnaud

v2:
- make the mc13892 behaviour configurable
- modify main mc13xxx driver instead of mc13892 regulator
- reorder Kconfig entry.
