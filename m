From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Feb 2011 17:41:22 +0530
Subject: [PATCH 0/3] OMAP2+ hwmod fixes
Message-ID: <1297858285-7056-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes some hwmod api return values
and also adds some state checks.
The hwmod iterator functions are made to
continue and not break if one of the
callback functions ends up with an error.

Series applies on 2.6.38-rc4 and is boot
tested on OMAP3430SDP and OMAP4430SDP
platforms.

Rajendra Nayak (3):
  OMAP2+: hwmod: Avoid setup if clock lookup failed
  OMAP2+: hwmod: Fix what _init_clock returns
  OMAP2+: hwmod: Do not break iterator fn's if one fails

 arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)
