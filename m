From: alchaiken@gmail.com (alchaiken at gmail.com)
Date: Sat,  5 Dec 2015 19:30:55 -0800
Subject: [PATCH 0/2] ARM: i.MX6QDL-SabreAuto: assert GPIO hog for imx-weim
Message-ID: <1449372657-18496-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

The parallel NOR that is attached to the i.MX6-SabreAuto WEIM switch
needs a GPIO asserted at boot in order to probe properly.  Employ the
GPIO hogging mechanism to set the GPIO properly.  Also, add partitions
subnode to NOR device-tree node to make MTD initialization work.

Alison Chaiken (2):
  bus: imx-weim: assert GPIO at boot in order to connect NOR
  ARM: dts: imx6qdl-sabreauto: enable partitions for parallel NOR

 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |  5 ++++
 drivers/bus/imx-weim.c                   | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.6.2
