From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 14 Dec 2009 12:19:38 +0200
Subject: [PATCH 0/4] mx25: add support for FEC on i.MX25 PDK
Message-ID: <cover.1260785451.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the FEC peripheral of the i.MX25 on the 
i.MX25 PDK board.

The first two patches are fixes for compilation and run failures. The third 
patch enables RMII if the FEC driver. Finally, the last patch adds the 
necessary board support code (pads, clock, etc.)

The FEC fix seems like an ugly hack to me. Suggestions for a better solution 
are welcome.

Baruch Siach (4):
  mx25: s/NO_PAD_CTL/NO_PAD_CTRL/
  mx25: don't force input on FEC pins
  fec: add support for Freescale i.MX25 PDK (3DS)
  mx25: add support for FEC on i.MX25 PDK

 arch/arm/mach-mx25/clock.c                  |    2 +
 arch/arm/mach-mx25/devices.c                |   19 ++++++++
 arch/arm/mach-mx25/devices.h                |    1 +
 arch/arm/mach-mx25/mx25pdk.c                |   40 ++++++++++++++++-
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |   64 +++++++++++++-------------
 arch/arm/plat-mxc/include/mach/mx25.h       |    4 ++
 drivers/net/fec.c                           |   22 +++++++++
 drivers/net/fec.h                           |    2 +
 8 files changed, 121 insertions(+), 33 deletions(-)
