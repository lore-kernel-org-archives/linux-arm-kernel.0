From: jason@lakedaemon.net (Jason Cooper)
Date: Tue,  9 Aug 2011 16:47:30 +0000
Subject: [PATCH 0/3 v2] RFC: marvell dreamplug dft support
Message-ID: <cover.1312906908.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

First, a warning.  Do not apply the last patch in the series!  It has
no hope of compiling.  I'm trying to learn how to add board support to
the Linux kernel _and_ now trying to learn how to do it using devicetree.

In short, I'm lost.  ;-)  Any and all help appreciated.

In my sad attempt to add devicetree support, I used
arch/arm/mach-kirkwood/include/mach/kirkwood.h to stub out the addresses.
It's my understanding that most peripherals on this SoC are register-based.
So, I haven't added external-bus{...}; yet.

Based on kirkwood.h, there doesn't seem to be any obvious register size
definition, should I omit that all around in my devicetree?

I'm guessing at a lot of the compatible="" properties, I simply chose the
.name string I found in the respective code.  Is this correct?

I see nothing obvious to indicate an irq handler similar to that mentioned
in [1].  Any thoughts?  I found the irq table, just no way to use it.

Also, I'll rename dreamplug-setup.c -> dreamplug-dt.c once I have something
working.

[1] has been a great help, thanks Grant!

thx,

Jason.

[1] http://devicetree.org/Device_Tree_Usage

Jason Cooper (3):
  arm/kirkwood: TEMP hack till mach-types is updated.
  arm/kirkwood: add dreamplug support.
  arm: kirkwood: dreamplug fdt support

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   64 +++++++++++++
 arch/arm/mach-kirkwood/Kconfig           |    8 ++
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/dreamplug-setup.c |  151 ++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types                |    1 +
 6 files changed, 227 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/mach-kirkwood/dreamplug-setup.c
