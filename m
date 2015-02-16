From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Feb 2015 15:58:23 +0000
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <54DF7F93.3040009@gmail.com>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
 <54DF7F93.3040009@gmail.com>
Message-ID: <20150216155823.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 06:02:11PM +0100, Sebastian Hesselbarth wrote:
> How about we copy the clk subsystem way of installing early probed
> pm for DT here?
> 
> For example:
> 
> #define PM_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
> 
> and
> 
> static int __init dove_pmu_init(struct device_node *np) { ... }
> PM_OF_DECLARE(dove_pmu, "marvell,dove-pmu", dove_init_pmu);

Well, Rob's response was basically "use the machine descriptor" so I
guess it needs to be explicitly called from
arch/arm/mach-mvebu/dove.c:dove_init().

If you disagree, please discuss with Rob (on To:) and try and find a
way forward and let me know how to deal with this.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
