From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:18 -0600
Subject: [PATCH 0/8] ARM: dts: dra7: Add ti-opp-supply nodes and enable 1.5 GHz
Message-ID: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series adds the additional regulators and ti-opp-supply nodes to enable
ABB regulator scaling and AVS Class0 for dra7 and am57 platforms. In addition
to this the 1.5 GHz OPP is enabled for any platforms in the dra7 and am57
family that support it based on the detection done by the ti-cpufreq driver.

Regards,
Dave

Dave Gerlach (8):
  ARM: dts: dra7: Add vbb-supply to cpu and additional voltages
  ARM: dts: dra7: Add MPU OPP supply node
  ARM: dts: dra7: Enable 1.5 GHz operation for the CPU
  ARM: dts: am57xx-beagle-x15-common: Add cpu0 vdd supply
  ARM: dts: dra7-evm: Add cpu0 vdd supply
  ARM: dts: dra72-evm-tps65917: Add cpu0 vdd supply
  ARM: dts: am571x-idk: Add cpu0 vdd supply
  ARM: dts: am572x-idk: Add cpu0 vdd supply

 arch/arm/boot/dts/am571x-idk.dts                |  4 ++++
 arch/arm/boot/dts/am572x-idk.dts                |  4 ++++
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  2 +-
 arch/arm/boot/dts/dra7-evm.dts                  |  2 +-
 arch/arm/boot/dts/dra7.dtsi                     | 29 +++++++++++++++++++++++--
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi       |  4 ++++
 6 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.15.1
