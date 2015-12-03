From: tony@atomide.com (Tony Lindgren)
Date: Thu,  3 Dec 2015 15:11:37 -0800
Subject: [PATCH 0/3] Add minimal support for dra62x j5-eco
Message-ID: <1449184300-15693-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are minimal changes to add support for dra62x also known as
jacinto 5 or j5-eco. We can leverage the dm814x support being fixed in
mainline kernel also for dra62x. Compared to dm814x, dra62x has a
bit different clocks and devices.

To boot j5-eco evm, you need the the patches below on v4.4-rc3 with
the following additional patches posted earlier.

Basic clock driver for dm814x:

http://marc.info/?l=linux-omap&m=144910652029316&w=2

Fixes for dm814x:

http://marc.info/?l=linux-omap&m=144901336001085&w=2

And also make sure you have the initcall level change patch that
is needed for having omap clock drivers as regular Linux device
drivers:

http://marc.info/?l=linux-omap&m=144890081111207&w=2

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
  ARM: dts: Add basic support for dra62x j5-eco SoC
  ARM: dts: Add minimal dra62x j5-eco evm support

 arch/arm/boot/dts/Makefile             |  3 ++-
 arch/arm/boot/dts/dra62x-clocks.dtsi   | 49 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 28 +++++++++++++++++++
 arch/arm/boot/dts/dra62x.dtsi          | 23 ++++++++++++++++
 arch/arm/mach-omap2/id.c               |  4 ++-
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra62x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x-j5eco-evm.dts
 create mode 100644 arch/arm/boot/dts/dra62x.dtsi

-- 
2.6.2
