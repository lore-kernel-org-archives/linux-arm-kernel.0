From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jul 2017 15:06:34 +0100
Subject: ARM: sunxi: "Unbalanced enable for IRQ 0" warning on A20
In-Reply-To: <aa19551d-c0dc-07c0-313a-d55dbda4d5ad@suse.de>
References: <aa19551d-c0dc-07c0-313a-d55dbda4d5ad@suse.de>
Message-ID: <20170701140634.GC4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 01, 2017 at 12:51:57PM +0200, Andreas F?rber wrote:
> [   33.683928] thermal thermal_zone0: failed to read out thermal zone (-110)
> [   33.690870] ------------[ cut here ]------------
> [   33.690901] WARNING: CPU: 0 PID: 161 at ../kernel/irq/manage.c:529
> __enable_irq+0x54/0x88
> [   33.690905] Unbalanced enable for IRQ 0

Why do we have new platforms using IRQ number 0 ?  0 for modern platforms
is supposed to mean "no IRQ".

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
