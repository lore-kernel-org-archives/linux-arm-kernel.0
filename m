From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Jun 2013 13:13:47 -0400
Subject: [PATCH 0/6] Marvell Orion SoC irqchip and clocksource
In-Reply-To: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130606171347.GJ23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 06:27:08PM +0200, Sebastian Hesselbarth wrote:
> This patch set introduces DT-aware irqchip and clocksource drivers for
> Marvell Orion SoCs (Kirkwood, Dove, Orion5x, MV78x00) and corresponding
> patches for Dove and Kirkwood to enable them for DT-boards.
> 
> The irqchip driver, of course, depends on Thomas Gleixner's work on
> irqdomain support for generic chip (tip irq/core).

Ah, this is why I wanted to look at the diffstat.  The dependencies
aren't nearly as complicated as I imagined.  :-)

> The ARM part of this patch set has a quite ridiculuous dependency havoc
> of mv643xx_eth DT support (current net-next) that will add to both irqchip
> and clocksource branches respectively. Therefore, I suggest that irq
> and clocksource maintainers take in the mere drivers (Patches 1+2) and
> Jason Cooper handles the remaining patches when all three drivers have
> surfaced on mainline linux.

The suggested approach is correct, but it should be pretty easy to apply
#3-6 once v3.11-rc1 drops.

thx,

Jason.
