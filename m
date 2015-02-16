From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Feb 2015 17:30:24 +0100
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <20150216155823.GO8656@n2100.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk> <54DF7F93.3040009@gmail.com>
 <20150216155823.GO8656@n2100.arm.linux.org.uk>
Message-ID: <54E21B20.10700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.2015 16:58, Russell King - ARM Linux wrote:
> On Sat, Feb 14, 2015 at 06:02:11PM +0100, Sebastian Hesselbarth wrote:
>> How about we copy the clk subsystem way of installing early probed
>> pm for DT here?
>>
>> For example:
>>
>> #define PM_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
>>
>> and
>>
>> static int __init dove_pmu_init(struct device_node *np) { ... }
>> PM_OF_DECLARE(dove_pmu, "marvell,dove-pmu", dove_init_pmu);
>
> Well, Rob's response was basically "use the machine descriptor" so I
> guess it needs to be explicitly called from
> arch/arm/mach-mvebu/dove.c:dove_init().

Ok, I am very fine with that, too.

Still, we'd have to find a proper place for the driver, don't we?

Sebastian
