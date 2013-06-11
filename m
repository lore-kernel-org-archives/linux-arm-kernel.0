From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Jun 2013 09:35:23 -0300
Subject: [PATCH 0/6] Marvell Orion SoC irqchip and clocksource
In-Reply-To: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130611123521.GA3996@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thu, Jun 06, 2013 at 06:27:08PM +0200, Sebastian Hesselbarth wrote:
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
> 
> I prepared a branch for anyone to test on Kirkwood and Dove which takes
> care of the above dependencies based on v3.10-rc4 plus tip irq/core,
> net-next, and arm-soc for-next (I know it is unstable but contains latest
> mvebu related patches already). When Thomas, John, and Jason agree the
> dependencies will vanish and only Jason has to take care of ARM patches
> for enabling DT-based mv643xx_eth, irqchip, and clocksource.
> 
> The branch can be found at
> 
> git://github.com/shesselba/linux-dove.git orion-irqchip-for-v3.11
> 
> and has been tested on Dove/CuBox and compile tested for Kirkwood.
> 
> Sebastian Hesselbarth (6):
>   irqchip: add support for Marvell Orion SoCs
>   clocksource: add Marvell Orion SoC timer
>   ARM: dove: move device tree nodes to DT irqchip and clocksource
>   ARM: kirkwood: move device tree nodes to DT irqchip and clocksource
>   ARM: dove: convert to DT irqchip and clocksource
>   ARM: kirkwood: convert to DT irqchip and clocksource
> 

I've done some tests on my Kirkwood Openblocks A6 using the latest
branch orion-irqchip-for-v3.11-v4. Everything works fine so:

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

For patches 3 to 6 I'm wondering if there's any reason why the irqchip and
clocksource changes are not separated. I'm probably being too picky but,
unless you have a good reason for having them together,
I think they should go separated, i.e. patches for irqchip on one side,
and patches for clocksource on the other.

Aside from that, the series looks good. Nice job!

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
