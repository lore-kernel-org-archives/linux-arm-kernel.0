From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Sep 2018 18:29:10 +0200
Subject: [PATCH 0/2] SFF support for ZII CFU1 and devel C.
Message-ID: <1535905752-17730-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the ZII CFU1 and Devel C have SFF modules. These patches add some
of them to the device tree description of these boards.

In order for the CFU1 to fully work, it requires patches submitted in
net-next. Without those patches, the link partner must already be up
when the SFF interface is configured up. There are no build time
dependencies, so merging them via different trees is not a problem.

Devel C generally has 2 SFF modules populated. The patch here adds
full support for SFF2. All the needed driver code is already present.
SFF3 is not yet supported by the mv88e6xxx driver. So the SFF3 device
itself is added to DT, but the module is not linked to a port.

Andrew Lunn (1):
  ARM: dts: vf610-zii-cfu1: Add SFF interface to switch

Russell King (1):
  ARM: dts: vf610-zii-dev-rev-c: add support for one SFF module

 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 27 ++++++++++++++
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 44 +++++++++++++----------
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.19.0.rc1
