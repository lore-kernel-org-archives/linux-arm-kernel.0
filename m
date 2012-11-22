From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2012 23:54:26 +0000
Subject: [PATCH 0/3] sdhci-dove GPIO support for card detection
Message-ID: <20121122235426.GT3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following three patches allow sdhci-dove to use a GPIO for card
presence detection.  This is a three stage process:

1. Clean up error paths by using devm_clk_get().
2. Use the two-stage sdhci initialization.
3. Implement the GPIO card detection support.

A very similar patch has been tested by Sebastian on the cubox; since
that version, I've changed the error printing slightly and dropped the
non-DT support for this feature as mainline doesn't have non-DT cubox
support.

 drivers/mmc/host/sdhci-dove.c |  108 +++++++++++++++++++++++++++++++++--------
 1 files changed, 88 insertions(+), 20 deletions(-)
