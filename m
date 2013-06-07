From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 07 Jun 2013 02:39:10 -0400
Subject: [PATCH 0/2] MCPM backend for Virtual Express TC2
Message-ID: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the MCPM backend enabling SMP secondary boot and CPU hotplug
on the VExpress TC2 big.LITTLE platform.  The method to allow CPU suspend
is also implemented.

Those patches have the following prerequisites:

- the vexpress/dual-cluster branch currently in ARM-SOC
  (commit 033a899c9b06)

- the VExpress SPC patches from Lorenzo here:
  http://news.gmane.org/group/gmane.linux.drivers.devicetree/thread=37483

For convenience I've pushed everything here:

  git://git.linaro.org/people/nico/linux TC2

Diffstat:


 arch/arm/mach-vexpress/Kconfig  |   9 ++
 arch/arm/mach-vexpress/Makefile |   1 +
 arch/arm/mach-vexpress/tc2_pm.c | 262 ++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)


Nicolas
