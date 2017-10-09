From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Oct 2017 10:48:33 +0200
Subject: [PATCH 0/2] ARM: dts: gr-peach: ETHER and OS Timers enable
Message-ID: <1507538915-16566-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,
   this small series contains other two updates for GR-Peach.

The first patch is a re-proposal of the previously sent one. I have received
indication from netdev people to move the properties describing reset line to
the phy node. I've been suggested to use a different node layout as well:

ether {
	mdio-bus {
		phy {
		};
	};
};

I have tested a couple of combinations and concluded this was not working for me
then fell back to the our usual one:

ether {
	phy {
	};
};

with 'reset-gpios' and 'reset-delay-us' properties moved from 'ether' node to
'phy' node.

Second patch enables ostm0 and ostm1 timers OS Timers which have greater
resolution compared to the already enabled MTU2 (32-bit vs 16-bits).
As the patch change log reports, OS Timers are automatically selected as clock
and clock event source. This patch has been suggested by Chris, as that's how
the BSP initializes timers by default.

Thanks
   j

Jacopo Mondi (2):
  ARM: dts: gr-peach: Add ETHER pin group
  ARM: dts: gr-peach: Enable ostm0 and ostm1 timers

 arch/arm/boot/dts/r7s72100-gr-peach.dts | 47 +++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--
2.7.4
