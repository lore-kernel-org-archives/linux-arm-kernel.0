From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 12 Dec 2011 20:15:25 +0200
Subject: [PATCHv11 0/8] OMAP3+: PRCM chain handler
Message-ID: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

PRCM chain handler is adding a support to the omap3+ kernel that
allows different drivers to use PRCM interrupt events for their
own purposes, typically this means IO wakeups. This work was
attempted to integrate as its own driver at some point of
the evolution of this set, however this was now postponed as
the lacking support is basically blocking a few drivers.

This is the version 11 of this set, now posted to linux-arm-kernel also
as cc. Contains just a couple of minor changes compared to previous
version proposed by Kevin Hilman.

Also, patch 8 is new (posted as a separate patch to l-o list earlier),
for supporting different irqs for different pads on the same hwmod.
This is needed at least by USB driver.

This version tested on omap3 beagle board, dynamic idle + suspend,
with and without off-mode. I have pushed two branches on a public
git tree:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git

branch: chain-prcm-v11
branch2: chain-prcm-v11-debug

Debug branch contains a few debugging related patches I've used
for testing purposes.

-Tero
