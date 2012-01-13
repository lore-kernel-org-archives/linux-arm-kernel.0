From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 00:43:59 +0000
Subject: [PATCH 0/2] Full DT IRQ support for versatile
Message-ID: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches move versatile over to instantiating both interrupt
controllers from the device tree.  I've tested this in qemu for both DT
and non-DT platforms but only with an initramfs.  I've seen interrupts
generated on both controllers for both boot methods.

Grant, Rob, this makes use of irqdomain again as I'm not sure what the
replacement is going to look like yet.  versatile works with DT in
mainline, but that's kind of lucky...  I know there's been patches to
make irq_domain_add_simple() return the irq_domain and can rebase if
needed.

Jamie Iles (2):
  versatile: sic: add device tree bindings
  versatile: dt: register interrupt controllers from dt

 .../devicetree/bindings/arm/versatile-sic.txt      |   27 ++++++++++
 arch/arm/mach-versatile/core.c                     |   27 +++-------
 arch/arm/mach-versatile/core.h                     |    1 +
 arch/arm/mach-versatile/versatile_dt.c             |   15 +++++-
 arch/arm/plat-versatile/Kconfig                    |    1 +
 arch/arm/plat-versatile/fpga-irq.c                 |   51 +++++++++++++++++++-
 arch/arm/plat-versatile/include/plat/fpga-irq.h    |    6 ++
 7 files changed, 106 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/versatile-sic.txt

-- 
1.7.5.4
