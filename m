From: david@lechnology.com (David Lechner)
Date: Wed, 4 Apr 2018 11:21:02 -0500
Subject: [PATCH v8 25/42] ARM: davinci: dm644x: add new clock init using
 common clock framework
In-Reply-To: <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-26-git-send-email-david@lechnology.com>
 <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
Message-ID: <b44de0a4-776d-153c-54e3-ce6ddc4f074f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 05:26 AM, Sekhar Nori wrote:
> On Friday 16 March 2018 08:22 AM, David Lechner wrote:
>> +static struct resource dm644x_pll1_resources[] = {
>> +	{
>> +		.start	= DAVINCI_PLL1_BASE,
>> +		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
> 
> The .end should be DAVINCI_PLL1_BASE + SZ_1K - 1, otherwise it prevents
> PLL2 from getting registered.
> 
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +};
>> +
>> +static struct platform_device dm644x_pll1_device = {
>> +	.name		= "dm644x-pll1",
>> +	.id		= -1,
>> +	.resource	= dm644x_pll1_resources,
>> +	.num_resources	= ARRAY_SIZE(dm644x_pll1_resources),
>> +};
>> +
>> +static struct resource dm644x_pll2_resources[] = {
>> +	{
>> +		.start	= DAVINCI_PLL2_BASE,
>> +		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
> 
> And this too should be fixed, else it prevents the PSC from getting
> registered.

Thanks. I've checked and this needs to be fixed for dm646x, dm355 and
dm365 as well.
