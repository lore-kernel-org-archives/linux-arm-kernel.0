From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 11 Jun 2013 10:45:40 +0200 (CEST)
Subject: [PATCH 0/6] Marvell Orion SoC irqchip and clocksource
In-Reply-To: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.LFD.2.02.1306111043200.22970@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Sebastian Hesselbarth wrote:

> This patch set introduces DT-aware irqchip and clocksource drivers for
> Marvell Orion SoCs (Kirkwood, Dove, Orion5x, MV78x00) and corresponding
> patches for Dove and Kirkwood to enable them for DT-boards.
> 
> The irqchip driver, of course, depends on Thomas Gleixner's work on
> irqdomain support for generic chip (tip irq/core).
> 
> The ARM part of this patch set has a quite ridiculuous dependency havoc
> of mv643xx_eth DT support (current net-next) that will add to both irqchip
> and clocksource branches respectively. Therefore, I suggest that irq
> and clocksource maintainers take in the mere drivers (Patches 1+2) and
> Jason Cooper handles the remaining patches when all three drivers have
> surfaced on mainline linux.

I provided a tip branch irq/for-arm, which contains only these changes
and can be pulled by SoC/subarch maintainers so we don't end up with a
dependency nightmare. Just mention that you pulled it from me when
sending the pull request to Linus.
 
Thanks,

	tglx
