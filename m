From: qy03fugy@stud.informatik.uni-erlangen.de (Christian Dietrich)
Date: Wed, 14 Jul 2010 13:31:29 +0200
Subject: [PATCH 0/3] Removing dead code
Message-ID: <cover.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!
       
        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

        I've been running a check on the drivers/usb sourcetree for
config Items not defined in Kconfig and found 3 such cases. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless.

        Each of the patches in this patchset removes on such dead
config Item, I'd be glad if you consider applying them. I've been
doing deeper analysis of such issues before and can do so again but
I'm not so sure they were fastly usefull.

        I build the patches against a vanilla kernel in order to
try if the kernel compiles with this patches

        Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

        Christian Dietrich

[0] http://vamos1.informatik.uni-erlangen.de/

Christian Dietrich (3):
  usb/gadget: Remove dead CONFIG_USB_LANGWELL_OTG
  usb/{gadget,host}: Remove dead CONFIG_CPU_PXA27x
  usb/host || arch/arm: Remove dead CONFIG_ARCH_KARO

 arch/arm/tools/mach-types         |    1 -
 drivers/usb/gadget/langwell_udc.c |   84 +------------------------------------
 drivers/usb/gadget/langwell_udc.h |    5 --
 drivers/usb/gadget/pxa27x_udc.c   |   16 -------
 drivers/usb/host/isp1362.h        |   24 +----------
 drivers/usb/host/ohci-pxa27x.c    |    8 ----
 6 files changed, 2 insertions(+), 136 deletions(-)
