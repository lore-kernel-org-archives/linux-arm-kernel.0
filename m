From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed,  2 May 2012 21:11:50 -0500
Subject: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
Message-ID: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently a patch went in for tidspbridge code, to ioremap
SCM registers and solve a build break[1]. However it has
been pointed out before that this is a layer violation
given that control module should handle its own registers, this
series is an attempt to create APIs for the users of these
registers.

With some adaptations this patch might also make use of it:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg66491.html

Patch: staging: tidspbridge: use scm functions to set boot address and mode,
will be sent separately to staging tree.

Tested on OMAP3 Beagleboard.

[1] http://www.mail-archive.com/devel at linuxdriverproject.org/msg18762.html

Omar Ramirez Luna (3):
  OMAP2+: control: new APIs to configure boot address and mode
  OMAP: dsp: interface to control module functions
  staging: tidspbridge: use scm functions to set boot address and mode

 arch/arm/mach-omap2/control.c                      |   43 ++++++++++++++++++++
 arch/arm/mach-omap2/control.h                      |    2 +
 arch/arm/mach-omap2/dsp.c                          |    4 ++
 .../include/mach/ctrl_module_core_44xx.h           |    1 +
 arch/arm/plat-omap/include/plat/dsp.h              |    3 +
 drivers/staging/tidspbridge/core/tiomap3430.c      |   32 +++-----------
 6 files changed, 60 insertions(+), 25 deletions(-)

-- 
1.7.4.1
