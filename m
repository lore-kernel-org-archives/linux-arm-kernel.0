From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 17:57:37 +0100
Subject: [PATCH 5/6] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <20120730161743.GN18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
 <20120730161743.GN18016@lunn.ch>
Message-ID: <5016BD01.9030508@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 17:17, Andrew Lunn wrote:

> Hi Ian
>
> Shouldn't there be two interrupt here?
>
> 292 orion_ge00_init(eth_data, 293
> GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM, 294
> IRQ_KIRKWOOD_GE00_ERR);

No. This is thanks to the horrific mess in the mv643xx driver - its got
two drivers in one source file, and they do horrid things like pass
round base addresses.

Im making an effort to try to split them out into seperate mdio and
MAC/PHY drivers.

This is a start. :)

-Ian
