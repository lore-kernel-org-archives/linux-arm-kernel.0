From: eric@anholt.net (Eric Anholt)
Date: Mon,  5 Mar 2018 12:28:01 -0800
Subject: [PATCH 0/5] VCHI DT bindings
Message-ID: <20180305202806.21219-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes a gross DT property and adds a DT binding for the
VCHI driver so that we can start probing it automatically on RPi.

This is useful immediately as it lets you use vcgencmd for measuring
clocks (we have code for this in Linux but no userland interface).
It'll also be useful as a base for getting the consumer drivers to
probe automatically, which I'm expecting we'll do using a bus provided
by VCHI, since we'll be able to do some service discovery on VCHI.

VCHI itself can't just use a bus from the firmware driver, because of
the regs and interrupts -- the firmware link it has is just to allow a
request to the VPU to bring up VCHI on this hardware doorbell.

Greg: I'm good with merging patch 1 whenever, but I'd like to make
sure Stefan has a chance to take a look at the cache-line-size
property change, at least.

Eric Anholt (5):
  staging: vc04_services: Remove dead FRAGMENTS_T
  staging: vc04_services: Remove cache-line-size property.
  dt-bindings: soc: Add a binding for the Broadcom VCHI services.
  ARM: dts: bcm2835: Add VCHI node to the Raspberry Pi boards.
  staging: vc04_services: Mark the "DT bindings" job done.

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 18 ++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  7 ++++++
 drivers/staging/vc04_services/interface/vchi/TODO  |  9 ++------
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
 .../interface/vchiq_arm/vchiq_pagelist.h           |  6 ------
 5 files changed, 35 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

-- 
2.16.2
