From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 Jan 2014 08:09:59 +0900
Subject: [PATCH 00/03] ARM: shmobile: Lager USBHS update
Message-ID: <20140129230959.22655.55645.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Lager USBHS update

[PATCH 01/03] ARM: shmobile: Remove Lager USBHS UDC ifdefs
[PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
[PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround

Update the Lager USB0 code to let the USBHS device always be present
and check for DIP switch configuration. To be able to check the DIP
switch configuration the r8a7790 PINCTRL bits need to be updated too.

With this series USB0 on Lager will be fixed to USB Function via the
USBHS driver. In theory the SoC can also use USB Host on this port
either via USBHS or PCI USB, but since cable detection is missing
it is possible for the user to misconfigure USB Host and drive VBUS
with the wrong cable. Because of that USB0 will be forced to stick
to Function-only in the Lager board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-20140127

 arch/arm/mach-shmobile/board-lager.c |   29 ++++++++++++++++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |    9 +++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)
