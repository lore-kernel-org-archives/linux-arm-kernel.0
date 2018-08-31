From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 31 Aug 2018 12:20:36 -0700
Subject: [PATCH v3 0/3] ARM: NSP updates to support switch interrupts/SFP
Message-ID: <20180831192039.11842-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series updates the ARM NSP DTS and BCM958625HR in order to
support the SFP connected to port 5 on these reference boards.

I will be submitting the functional changes to drivers/net/dsa/b53 once
net-next opens back up, but this is largely independent from getting
these 3 patches out.

Thank you

Changes in v3:

- changes i2c controller node name from i2c to i2c (Ray)
- updated binding patch to have bulleted reg-names and interrupt-names
  (Rob)


Changes in v2:

- added missing managed = "in-band-status" property
- reworded the commit message to explain the limitation of i2c-proc
  is of 63 bytes per transfer, not 256 bytes

Florian Fainelli (3):
  ARM: dts: NSP: Enable SFP on bcm958625hr
  dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
  ARM: dts: NSP: Wire up switch interrupts

 .../devicetree/bindings/net/dsa/b53.txt       | 36 +++++++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 31 +++++++++++++++-
 arch/arm/boot/dts/bcm958625hr.dts             | 26 ++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.17.1
