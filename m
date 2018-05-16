From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 May 2018 11:21:15 +0530
Subject: [PATCH v10 02/27] clk: davinci: da850-pll: change PLL0 to
 CLK_OF_DECLARE
In-Reply-To: <88dec9b1-5f4d-a1ac-2b63-b30ae7665851@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-3-david@lechnology.com>
 <9203489d-0a5a-103a-67ea-d3e89bb7ebc4@ti.com>
 <88dec9b1-5f4d-a1ac-2b63-b30ae7665851@lechnology.com>
Message-ID: <665f5ea0-1865-0545-a1ef-7e971f3ba9d9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2018 09:12 PM, David Lechner wrote:
> On 05/15/2018 08:31 AM, Sekhar Nori wrote:
>> On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
>>> +void of_da850_pll0_init(struct device_node *node)
>>> ? {
>>> -??? return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
>>> -?????????????????? &da850_pll0_obsclk_info,
>>> -?????????????????? da850_pll0_sysclk_info, 7, base, cfgchip);
>>> +??? void __iomem *base;
>>> +??? struct regmap *cfgchip;
>>> +
>>> +??? base = of_iomap(node, 0);
>>> +??? if (!base) {
>>> +??????? pr_err("%s: ioremap failed\n", __func__);
>>> +??????? return;
>>> +??? }
>>> +
>>> +??? cfgchip = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
> 
> In your previous review, you pointed out that the error did not need to
> be handled here because it is handled later in davinci_pll_clk_register().>
> We get a warning there because cfgchip is only needed for unlocking the
> PLL for CPU frequency scaling and is not critical for operation of the
> clocks.

Oops, forgot about that :)

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
