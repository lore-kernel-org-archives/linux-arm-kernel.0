From: jgutierrez@ti.com (Gutierrez, Juan)
Date: Fri, 13 Apr 2012 16:53:07 -0500
Subject: [PATCH 0/3] Fixes in preparation for enabling Dsp in omap4
In-Reply-To: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
Message-ID: <CADVn9RG_WFh3d8P=cfC_O_5vbvE0YELDwbJL66uqO2My8D4bzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches provides the foundation for enabling
OMAP4 Dsp (Tesla) as remote processor.

The first patch is a generic fix for mailbox in mach-omap2.
Without this patch, the irq for a mailbox instance other than
the first one is not properly enabled.

The second patch fixes the clock and irq names for the Tesla
iommu in omap4 and enable it by default.

The third patch adds a generic mechanism in remoteproc for
loading the boot address in a special bootloader register, if
needed by the remoteproc like is the case for Tesla in omap4.

Juan Gutierrez (3):
?omap: mailbox: enable mailbox irq per instance
?OMAP4: iommu: fix irq and clock name for dsp-iommu
?omap: remoteproc: add support for a boot register

?arch/arm/mach-omap2/mailbox.c ? ? ? ? ? ? ? ?| ? ?2 --
?arch/arm/mach-omap2/omap-iommu.c ? ? ? ? ? ? | ? ?6 ++----
?arch/arm/plat-omap/include/plat/remoteproc.h | ? ?2 ++
?arch/arm/plat-omap/mailbox.c ? ? ? ? ? ? ? ? | ? ?3 +++
?drivers/remoteproc/omap_remoteproc.c ? ? ? ? | ? 19 +++++++++++++++++++
?5 files changed, 26 insertions(+), 6 deletions(-)

--
1.7.5.4
