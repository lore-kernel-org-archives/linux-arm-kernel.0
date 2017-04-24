From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 24 Apr 2017 18:26:51 +0800
Subject: [linux-sunxi] Re: [PATCH v5 02/11] clk: sunxi-ng: add support for
 DE2 CCU
In-Reply-To: <20170424085109.p44bmzbyjkuf7ckv@lukather>
References: <20170423103754.50012-1-icenowy@aosc.io>
 <20170423103754.50012-3-icenowy@aosc.io>
 <20170424085109.p44bmzbyjkuf7ckv@lukather>
Message-ID: <9def8a6b635880095e6b75e3a53af1f4@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-04-24 16:51?Maxime Ripard ???
> Hi,
> 
> On Sun, Apr 23, 2017 at 06:37:45PM +0800, Icenowy Zheng wrote:
>> +static const struct of_device_id sunxi_de2_clk_ids[] = {
>> +	{
>> +		.compatible = "allwinner,sun8i-a83t-de2-clk",
>> +		.data = &sun8i_a83t_de2_clk_desc,
>> +	},
>> +	{
>> +		.compatible = "allwinner,sun50i-h5-de2-clk",
>> +		.data = &sun50i_a64_de2_clk_desc,
>> +	},
>> +	/*
>> +	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
>> +	 * DE2 really working.
>> +	 * So there's currently no A64 compatible here.
>> +	 * H5 shares the same reset line with A64, so here H5 is using the
>> +	 * clock description of A64.
>> +	 */
>> +	{ }
>> +};
> 
> So that A64 driver would require more than just what you defined in
> the binding in order to operate?

Yes. When trying to do A64 driver, I will send out first a patch to
add the needed binding bit.

> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
