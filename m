From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed,  6 May 2015 15:13:58 +0200
Subject: [PATCH 0/2] ARM: mvebu: Linksys WRT1200AC and WRT1900AC v2 support
Message-ID: <1430918040-17307-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add support for the Linksys WRT1200AC (Caiman) and
the Linksys WRT1900AC v2 (Cobra).
 
Both boards have:
 
- 2 Marvell 88W8864 radios
- 1 USB 3.0 port
- 1 USB 2.0/eSATAp port
- 2 Ethernet interfaces connected to a 88E6176 switch (1x WAN + 4x LAN)
- 128MB NAND flash
- 512MB RAM

I didn't have much luck getting DSA work in this configuration yet,
so (for now) we use the bootloader configured layout for the switch.
 
The only difference between the two boards is the radio configuration
(2x2 vs 3x3), so everything except the leds (to be named properly)
is in the dtsi file. When the wireless driver will be submitted
upstream, the powertables (calibration data) will end up in the board
specific files, tho.


Imre
