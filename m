From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 16 Sep 2010 14:19:59 +0200
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
In-Reply-To: <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:

> OMAP SOCs have a standard set of tuples consisting of frequency and
> voltage pairs that the device will support per voltage domain. ?These
> are called Operating Performance Points or OPPs.
> (...)
> This introduces a common handling OPP mechanism accross all OMAPs.
> As a start this is used for OMAP3.

OPPs are a generic concept, it's in silicon construction textbooks and all.
Should this code not be made generic instead? You wouldn't make
regulators or even DMA platform-specific these days, so why should
OPPs be?

What in this code is actually OMAP-specific, more than that you name
some functions omap_*, and how hard would it be to put it under
arch/arm/common/*.c
arch/arm/include/asm/*.h

Possible even higher up in the directory hiearchy in include/linux/opp.h
for the header and drivers/opp/*.c, because I think SuperH and power
are not that different in this respect.

Yours,
Linus Walleij
