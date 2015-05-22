From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Fri, 22 May 2015 08:58:34 -0700
Subject: [GIT PULL] ARM: Keystone updates for v4.2
Message-ID: <1432310314-5090-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull keystone update for 4.2. Since there was just one
config update, sending it along with dts changes. The MMU
switching series which includes few keystone arch update will
go via RMK's tree because of dependencies with core code.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-for-4.2

for you to fetch changes up to b8c80afb65a0bcf55875194ce8cc9cea69aed845:

  ARM: dts: k2l: fix the netcp range size (2015-05-22 08:52:15 -0700)

----------------------------------------------------------------
ARM: Keystone updates for v4.2

Update contains:
        - Keystone EVM(s) dts files updates to add NETCP driver.
        - config update to enable NETCP driver by default.

----------------------------------------------------------------
Murali Karicheri (7):
      ARM: keystone: defconfig: enable netcp driver by default
      ARM: dts: k2hk-evm: Add device bindings for netcp driver
      ARM: dts: k2e-evm: Add device bindings for netcp driver
      ARM: dts: k2l-evm: Add device bindings for netcp driver
      ARM: dts: k2hk: fix the netcp range size
      ARM: dts: k2e: fix the netcp range size
      ARM: dts: k2l: fix the netcp range size

 arch/arm/boot/dts/k2e-evm.dts       |   1 +
 arch/arm/boot/dts/k2e-netcp.dtsi    | 206 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2e.dtsi          |   1 +
 arch/arm/boot/dts/k2hk-evm.dts      |   1 +
 arch/arm/boot/dts/k2hk-netcp.dtsi   | 208 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2hk.dtsi         |   1 +
 arch/arm/boot/dts/k2l-evm.dts       |   1 +
 arch/arm/boot/dts/k2l-netcp.dtsi    | 189 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2l.dtsi          |   1 +
 arch/arm/configs/keystone_defconfig |   6 ++
 10 files changed, 615 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2e-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-netcp.dtsi
