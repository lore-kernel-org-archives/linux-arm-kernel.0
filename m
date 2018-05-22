From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 May 2018 15:08:04 +0530
Subject: =?UTF-8?Q?Re:_[PATCH_v11_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
In-Reply-To: <20180518164829.27052-1-david@lechnology.com>
References: <20180518164829.27052-1-david@lechnology.com>
Message-ID: <850a0ec9-53aa-02a5-ecbd-e068b13b2764@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Friday 18 May 2018 10:18 PM, David Lechner wrote:
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 3 patches fix some issues with the clock
> drivers that have already been accepted into the mainline kernel.
> 
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
> 
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
> 
> The final four patches add device tree clock support to the one SoC that
> supports it.
> 
> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
> board file).

If you do end up sending a v12, you can leave out the mach-davinci
portions unless there are any changes you need to make. I will pick them
up from this series once the driver dependencies are merged.

I do hope the drivers/clk/* changes can be merged from v4.18.

Thanks,
Sekhar
