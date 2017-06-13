From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 13 Jun 2017 11:28:42 +0200
Subject: [PATCHv2 0/5] OMAP4: crypto support
Message-ID: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds crypto support for OMAP4, which was missing for some reason.
This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
DES are working according to selftest.

Changes since PATCHv1:
 * remove patch adding des_fck to DT
 * add patch removing aes[12]_fck from DT
 * add patch renaming hwmod aes to aes1 in DT
 * update hwmod patches according to feedback from Tero
 * add patch for aes2 hwmod

-- Sebastian

Sebastian Reichel (5):
  ARM: dts: omap4: Fix aes entry
  ARM: dts: omap4.dtsi: remove aes[12]_fck
  ARM: OMAP4: hwmod data: add aes1
  ARM: OMAP4: hwmod data: add aes2
  ARM: OMAP4: hwmod data: add des

 arch/arm/boot/dts/omap4.dtsi               |   4 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |  16 -----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 100 +++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 18 deletions(-)

-- 
2.11.0
