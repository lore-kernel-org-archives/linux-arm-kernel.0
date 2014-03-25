From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 00:33:57 +0100
Subject: [PATCH 0/2] ARM: mvebu: add a clock for mdio nodes on Armada
 370/38x/XP
Message-ID: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

Here is a set of two patches that add a clock specification to the
mdio node on Armada 370/XP and Armada 38x. This allows the mvmdio
driver to work properly when loaded as a module, before mvneta is
loaded.

I've separated the Armada 370/XP and Armada 38x fixes in two patches,
because the Armada 370/XP fix should be pushed to stable, while the
Armada 38x does not need to be pushed to stable since Armada 38x
support only appears in 3.15.

Thanks,

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: ensure the mdio node has a clock reference on Armada
    370/XP
  ARM: mvebu: ensure the mdio node has a clock reference on Armada 38x

 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 arch/arm/boot/dts/armada-38x.dtsi    | 1 +
 2 files changed, 2 insertions(+)

-- 
1.8.3.2
