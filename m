From: alison_chaiken@mentor.com (Alison Chaiken)
Date: Tue, 8 Dec 2015 15:48:38 -0800
Subject: [PATCH v2 0/2] ARM: dts: imx6qdl-sabreauto: employ GPIO init-val for
 p-NOR
In-Reply-To: <20151207082440.GY11966@pengutronix.de>
References: <20151207082440.GY11966@pengutronix.de>
Message-ID: <1449618520-3432-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parallel NOR that is attached to the i.MX6-SabreAuto WEIM switch
needs a GPIO asserted at boot in order to probe properly.  Employ the
GPIO init-val mechanism to set the GPIO.  Also, add partitions subnode
to NOR device-tree node to make MTD initialization work.

Alison Chaiken (2):
  ARM: dts: imx6qdl-sabreauto: assert GPIO at boot in order to connect
    NOR
  ARM: dts: imx6qdl-sabreauto: enable partitions for parallel NOR

 arch/arm/boot/dts/imx6qdl-sabreauto-eim-nor.dtsi | 43 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  4 +++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabreauto-eim-nor.dtsi

-- 
2.6.2
