From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 5 May 2014 14:58:27 -0500
Subject: [PATCH 0/2] Add VTT regulators for DDR3 AMx3xx Boards
Message-ID: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The am335x-evmsk and am437x-gp-evm both have a gpio controlled regulator
for DDR3 VTT voltage. This is configured by boot loader and previously
just left at that but it is better to define a fixed regulator to control
the gpio so that the kernel is aware of it.

Previous discussion here [1].

Original am437x-gp-evm patch has been updated to reflect actual voltage
supplied by VTT regulator.

Regards,
Dave

[1] http://marc.info/?l=linux-omap&m=139819277623028&w=2

Dave Gerlach (2):
  ARM: dts: am437x-gp-evm: Add vtt_fixed regulator
  ARM: dts: am335x-evmsk: Add vtt_fixed regulator

 arch/arm/boot/dts/am335x-evmsk.dts  | 11 +++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 2 files changed, 22 insertions(+)

-- 
1.9.0
