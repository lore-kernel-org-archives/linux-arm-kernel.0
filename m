From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:16 -0800
Subject: [PATCH v3 0/8] ARM: dts: Switch to new DSA binding
Message-ID: <20170117182224.32212-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series converts the in-tree users to utilize the new (relatively)
DSA binding that was introduced with commit 8c5ad1d6179d ("net: dsa: Document
new binding"). The legacy binding node is kept included, but is marked
disabled.

Changes in v3:

- collected tags from Andrew and Russell
- added missing change to arch/arm/boot/dts/kirkwood-rd88f6281-a.dts

Changes in v2:

- patch 1: Use an hexadecimal reg property
- patch 2: fixed the subject
- patch 3: s/okay/disabled/ for the legacy DSA node
- patches 7/8: fixed a stray whitespace

In about 2-3 releases we may consider removing the old DSA binding entirely
from the kernel.

Thank you!

Florian Fainelli (8):
  ARM: dts: armada-370-rd: Utilize new DSA binding
  ARM: dts: armada-385-linksys: Utilize new DSA binding
  ARM: dts: armada-388-clearfog: Utilize new DSA binding
  ARM: dts: armada-xp-linksys-mamba: Utilize new DSA binding
  ARM: dts: kirkwood-dir665: Utilize new DSA binding
  ARM: dts: kirkwood-linksys-viper: Utilize new DSA binding
  ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new DSA binding
  ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding

 arch/arm/boot/dts/armada-370-rd.dts            | 44 +++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi      | 52 ++++++++++++++++++++-
 arch/arm/boot/dts/armada-388-clearfog.dts      | 65 ++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 53 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-dir665.dts          | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts    | 11 +++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 44 +++++++++++++++++
 9 files changed, 415 insertions(+), 1 deletion(-)

-- 
2.9.3
