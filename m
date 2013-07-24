From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:09:25 +0200
Subject: [PATCH 0/3] sh-pfc: Don't include mach/*.h headers were not required
Message-ID: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The (long) road to multiplatform kernels requires getting rid of mach/*.h
headers in device drivers. This patch set removes some of the included mach
headers from the sh-pfc driver. The only remaining one is mach/irqs.h, to get
the irq_pin() macro. This will require more work, see [1] for a discussion of
the issue.

The patches are based on v3.11-rc2. Linus, do you usually pick pinctrl patches
from the list, or should I send you a pull request ?

[1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg473450.html

Laurent Pinchart (3):
  sh-pfc: Remove unneeded mach/<soc>.h includes
  sh-pfc: sh7372: Replace <mach/irqs.h> with <linux/sh_intc.h>
  sh-pfc: sh73a0: Remove EXT_IRQ16L and EXT_IRQ16H macros

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  1 -
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  |  4 +--
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 68 +++++++++++++++++-------------------
 4 files changed, 33 insertions(+), 41 deletions(-)

-- 
Regards,

Laurent Pinchart
