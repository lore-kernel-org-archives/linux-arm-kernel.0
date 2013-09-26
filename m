From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Sep 2013 10:36:55 +0200
Subject: [PATCH 2/5] ARM: mvebu: Add Core Divider clock device-tree binding
In-Reply-To: <20130925213730.GA19371@localhost>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost>
Message-ID: <20130926083655.GB18244@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel

+#define CORE_CLOCK_DIVIDER_RATIO_OFFSET		0x8
...

reg = readl(corediv->reg + CORE_CLOCK_DIVIDER_RATIO_OFFSET);

...

+Example:
+
+corediv_clk: corediv-clocks at 18740 {
+	      compatible = "marvell,armada-370-corediv-clock";
+	      reg = <0x18740 0x8>;
+	      #clock-cells = <1>;
+	      clocks = <&pll>;
+};

The reg property seems to be wrong.

    Andrew
