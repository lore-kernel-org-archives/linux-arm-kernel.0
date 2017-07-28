From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Jul 2017 18:19:12 -0500
Subject: [PATCH 0/6] Add DSP DT nodes on Keystone platforms
Message-ID: <20170728231918.16778-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

The following series adds the DT nodes for the DSP devices present
on the Keystone2 66AK2H/K, 66AK2L and 66AK2E SoCs. They are disabled
in the base dts files, and enabled in the corresponding board files
alongside an added common reserved CMA pool that is used by all the
DSP devices. The bindings and driver support were added to mainline
in 4.13-rc1, and this series adds the dt portions. Nodes are added
as per bindings in
Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt

Validation done on K2HK EVM, K2L EVM and K2E EVM. Supported features
include basic load/boot (tested with rpmsg_client_sample) and Error
Recovery (after reverting a patch merged in 4.13-rc1 that has caused
a kernel crash, see [1]). Functionality with CMA nodes from HighMem
require a patch in the virtio_rpmsg_bus core [2].

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=150127179030802&w=2
[2] https://patchwork.kernel.org/patch/9549911/

Sam Nelson (3):
  ARM: dts: keystone-k2hk-evm: Add and enable common DSP CMA memory pool
  ARM: dts: keystone-k2l-evm: Add and enable common DSP CMA memory pool
  ARM: dts: keystone-k2e-evm: Add and enable DSP CMA memory pool

Suman Anna (3):
  ARM: dts: keystone-k2hk: Add DSP nodes
  ARM: dts: keystone-k2l: Add DSP nodes
  ARM: dts: keystone-k2e: Add DSP node

 arch/arm/boot/dts/keystone-k2e-evm.dts  |  18 +++++
 arch/arm/boot/dts/keystone-k2e.dtsi     |  20 +++++
 arch/arm/boot/dts/keystone-k2hk-evm.dts |  53 ++++++++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi    | 139 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2l-evm.dts  |  33 ++++++++
 arch/arm/boot/dts/keystone-k2l.dtsi     |  71 ++++++++++++++++
 6 files changed, 334 insertions(+)

-- 
2.13.1
