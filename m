From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:16 -0400
Subject: [PATCH 00/13] The big.LITTLE In-Kernel Switcher (IKS), part 1
Message-ID: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial posting of the b.L switcher patches for public review.
The tentative goal is to have those patches merged upstream during the
next (v3.12) merge window.

The rationale for this code can be found here:

   http://lwn.net/Articles/481055/

Here is the first part of the patch series with only the core patches
providing basic switcher functionality.  The second part consists of
optimizations to reduce switching latency as well as tracing
infrastructure support.  The third part adds switcher support to the
arm_big_little cpufreq driver.

To simplify the review process, only the first part is posted for
review at this time.  The first and second parts still can be found here:

   git://git.linaro.org/people/nico/linux iks

The first and second parts are meant to go through RMK's tree.
The third part should be merged via the cpufreq tree once at least
the first part has been accepted for mainline inclusion.

As the diffstat shows, this code is very much self contained and doesn't
really intrude into core parts of the kernel.


 arch/arm/Kconfig                       |  25 ++
 arch/arm/common/Makefile               |   2 +
 arch/arm/common/bL_switcher.c          | 611 +++++++++++++++++++++++++++
 arch/arm/common/bL_switcher_dummy_if.c |  71 ++++
 arch/arm/include/asm/bL_switcher.h     |  17 +
 arch/arm/kernel/sleep.S                |  25 +-
 arch/arm/kernel/suspend.c              |   8 +-
 drivers/irqchip/irq-gic.c              | 102 ++++-
 include/linux/irqchip/arm-gic.h        |   5 +
 9 files changed, 846 insertions(+), 20 deletions(-)


Nicolas
