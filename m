From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 12:59:33 +0000
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <65456683.XbdNkPUDTs@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <89767639.F6rHWX5yIj@wuerfel>
 <20150313122944.GF8656@n2100.arm.linux.org.uk>
 <65456683.XbdNkPUDTs@wuerfel>
Message-ID: <20150313125933.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 01:42:35PM +0100, Arnd Bergmann wrote:
> Ok. Given that the device is (also) an irqchip, would it work to use
> IRQCHIP_DECLARE() to have the driver initialized at init_irq() time
> as an alternative, or is that too early for some of the things this
> driver does?

I've just looked at that - it's not as easy as that, the macro is
defined in drivers/irqchip/irqchip.h which would need a relative
path to pick up - I'm not a fan of relative include paths.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
