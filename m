From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 12:50:13 +0100
Subject: Cache line size definition in arch/arm/mm/Kconfig
In-Reply-To: <551BD9BF.8090808@free.fr>
References: <5512C7A4.3000302@free.fr> <5515423E.4020802@free.fr>
 <20150327120601.GB4019@n2100.arm.linux.org.uk>
 <55155EE9.6020600@free.fr> <551BD9BF.8090808@free.fr>
Message-ID: <20150401115013.GA24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 01:42:55PM +0200, Mason wrote:
> Example patch for illustration purposes (only compile-tested)
> 
> (There is probably a much more elegant way to get 32-byte aligned
> memory allocations.)
> 
> Regards.
> 
> 
> diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
> index c0e2512..77b91c5 100644
> --- a/drivers/clocksource/mmio.c
> +++ b/drivers/clocksource/mmio.c
> @@ -10,34 +10,24 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -struct clocksource_mmio {
> -       void __iomem *reg;
> -       struct clocksource clksrc;

Just swap the order of these.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
