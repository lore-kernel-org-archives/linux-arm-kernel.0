From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Dec 2012 10:06:22 +0100
Subject: [PATCH V2 0/4] add RTC support for Armada 370 and Armada XP
Message-ID: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This small patch set adds RTC support for Armada 370 and Armada XP. It
was successfully tested on the evaluation board. The third patch add
the lacking documentation for the device tree binding and was already
taken by Grant Likely, I keep this one in the series for
coherency. The only differences with the previous patch set was the
add of the Acked-by from Andrew Lunn and a new small patch to update
of the mvebu_configuration. I also split the patch wich add the RTC
support in two part, one for the RTC subsytem and on for
mach-mvebu. This series is 3.9 material.

Alessandro,
could you take the first patches if you agree with it?

Jason,

I wait for a while if there any feedback, then I will send you a git
pull request. If I understood well your workflow I will do 2 git pull
one for dt and one for defconfig.

Thanks


Gregory CLEMENT (4):
  rtc: Add support of rtc-mv for MVEBU SoCs
  arm: mvebu: Add RTC support for Armada 370 and Armada XP
  rtc: rtc-mv: Add the device tree binding documentation
  arm: mvebu: Update defconfig with Marvell RTC support

 .../devicetree/bindings/rtc/orion-rtc.txt          |   18 ++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    6 ++++++
 arch/arm/configs/mvebu_defconfig                   |    1 +
 drivers/rtc/Kconfig                                |    2 +-
 4 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/orion-rtc.txt

-- 
1.7.9.5
