From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:19 +0100
Subject: [PATCH v2 00/16] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
Message-ID: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
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

The primary IRQ handlers have been written in C, and the performance
degradation is hardly noticeable. Should some tests reveal a major
increase in latency, it is always possible to restore the ASM version.

This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
and Harmony. Patches against next-20110926 plus my PPI series.
