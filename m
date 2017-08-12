From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 12 Aug 2017 12:04:14 +0800
Subject: [PATCH v3 08/10] clk: sunxi-ng: support R40 SoC
In-Reply-To: <20170529073428.f5os7g5e666v4xnp@wens.csie.org>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-9-icenowy@aosc.io>
 <20170529073428.f5os7g5e666v4xnp@wens.csie.org>
Message-ID: <7e211ba8fd8ae0296f678294d09fcf0d@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-29 15:34?Chen-Yu Tsai ???
> Hi,
> 
> On Sat, May 27, 2017 at 06:23:06PM +0800, Icenowy Zheng wrote:
>> Allwinner R40 SoC have a clock controller module in the style of the
>> SoCs beyond sun6i, however, it's more rich and complex.
>> 
>> Add support for it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v3:
>> - Rebased on current linux-next.
>> Changes in v2:
>> - Fixes according to the SoC's user manual.
>> 
>>  drivers/clk/sunxi-ng/Kconfig              |   10 +
>>  drivers/clk/sunxi-ng/Makefile             |    1 +
>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c      | 1153 
>> +++++++++++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      |   68 ++
>>  include/dt-bindings/clock/sun8i-r40-ccu.h |  191 +++++
>>  include/dt-bindings/reset/sun8i-r40-ccu.h |  129 ++++
>>  6 files changed, 1552 insertions(+)
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
>>  create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
>>  create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h
>> 
> ...
>> +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
>> +				   "osc24M", 0x04c,
>> +				   8, 7,	/* N */
> 
> N has minimum and maximum limits.

These constraints are never implemented in old SoCs.

>> --
>> 2.12.2
>> 
