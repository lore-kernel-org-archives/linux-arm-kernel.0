From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 7 May 2014 17:46:36 +0530
Subject: [PATCH V6 0/2] arm: dts: dra7: Updates for adding crossbar device
Message-ID: <1399464998-23216-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some socs have a large number of interrupts requests to service
the needs of its many peripherals and subsystems. All of the interrupt
requests lines from the subsystems are not needed at the same
time, so they have to be muxed to the controllers appropriately.
In such places a interrupt controllers are preceded by an
IRQ CROSSBAR that provides flexibility in muxing the device interrupt
requests to the controller inputs.

The dts file update to support the crossbar device and convert
peripheral irq numbers to crossbar number are added here.

This is a rebase on top of 3.15-rc4

This series depends on crossbar-driver-fixes sent below
http://marc.info/?l=linux-omap&m=139929963420299&w=2

[V6] Reordered patch 3 to patch 1 and
     squashed patch 2 and 3 from V5 in to patch 2

Sricharan R (2):
  arm: dts: dra7: Add routable-irqs property for gic node
  arm: dts: dra7: Add crossbar device binding

 arch/arm/boot/dts/dra7.dtsi |  109 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

-- 
1.7.9.5
