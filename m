From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 16:43:22 +0900
Subject: [PATCH/RFC 0/4] ARM: shmobile: marzen: Initialise SCIF devices using
 DT
Message-ID: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to provide a working prototype for enabling
SCIF devices using DT on the marzen board when booting using multiplatform.

This series aims to be in keeping with the discussion both online
and offline relating to "[PATCH/RFC] ARM: shmobile: Koelsch DT serial
integration prototype" (Magnus Damm, 21st April 2014).

Other relevant work in this area includes:

* "[PATCH v4 0/2] [RESEND] Lager and Koelsch reference serial port support"
  (Laurent Pinchart, 11th February 2014).
  Deprecated by the above mentioned discussion.

* "[PATCH v4 00/11] CCF support for Renesas r7s72100"
  (Wolfram Sang, 28th April 2014).
  I believe the approach of Wolfram's r7s72100 work and
  my marzen work are quite similar if not the same.


This series depends on:
[PATCH v5 00/20] ARM: shmobile: r8a7779, marzen: CCF and multiplatform

This series was created and tested with the above mentioned series applied
on top of the renesas-next-v3.15-rc1-20140416 tag of my renesas tree.

This series works in conjunction with but does not have a run or compile
time dependency on:
[PATCH/RFC v2] serial: sh-sci: Add device tree support for r8a7779


Simon Horman (4):
  ARM: shmobile: r8a7779: Add scif nodes to dtsi
  ARM: shmobile: marzen: Remove early_printk from command line
  ARM: shmobile: marzen: Initialise SCIF devices using DT
  ARM: shmobile: marzen: Use disabled variant of clock workaround for
    scif devices

 arch/arm/boot/dts/r8a7779-marzen.dts            | 24 ++++++++--
 arch/arm/boot/dts/r8a7779.dtsi                  | 60 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-marzen-reference.c | 12 ++---
 arch/arm/mach-shmobile/setup-r8a7779.c          | 10 ++---
 4 files changed, 91 insertions(+), 15 deletions(-)

-- 
1.8.5.2
