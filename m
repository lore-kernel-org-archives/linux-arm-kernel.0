From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Feb 2015 16:52:54 +0000
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <54E21B20.10700@gmail.com>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
 <54DF7F93.3040009@gmail.com>
 <20150216155823.GO8656@n2100.arm.linux.org.uk>
 <54E21B20.10700@gmail.com>
Message-ID: <20150216165254.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 05:30:24PM +0100, Sebastian Hesselbarth wrote:
> On 16.02.2015 16:58, Russell King - ARM Linux wrote:
> >On Sat, Feb 14, 2015 at 06:02:11PM +0100, Sebastian Hesselbarth wrote:
> >>How about we copy the clk subsystem way of installing early probed
> >>pm for DT here?
> >>
> >>For example:
> >>
> >>#define PM_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
> >>
> >>and
> >>
> >>static int __init dove_pmu_init(struct device_node *np) { ... }
> >>PM_OF_DECLARE(dove_pmu, "marvell,dove-pmu", dove_init_pmu);
> >
> >Well, Rob's response was basically "use the machine descriptor" so I
> >guess it needs to be explicitly called from
> >arch/arm/mach-mvebu/dove.c:dove_init().
> 
> Ok, I am very fine with that, too.
> 
> Still, we'd have to find a proper place for the driver, don't we?

Yep - I'm not sure creating drivers/pmu for (at the moment) one driver
is a particularly good idea.  Maybe something in drivers/soc/ ?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
