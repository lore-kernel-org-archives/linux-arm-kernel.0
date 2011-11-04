From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:34 +0000
Subject: [PATCH v3 00/17] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
Message-ID: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multiple primary interrupt controllers in the same
image, it is necessary to use the MULTI_IRQ_HANDLER config option.

This patch series makes a first step in that direction by:
- having the GIC code to provides a global handler,
- make GIC users to provide this handler from their machine descriptor.

A side effect of this is that it forces OMAP2/3 platforms to be
converted too in order to preserve the MULTI_OMAP feature. This leads
to a certain simplification of the interrupt handling for the
OMAP2/3/4 platforms.

This series has been tested by myself on VE (A9, A5, A15), PB11MP,
Panda, IGEPv2, Harmony and Origen, as well as on other platforms by
people who tested it. Patches against next-20111104 plus my "ARM: gic:
allow GIC to support non-banked setups" patch.
