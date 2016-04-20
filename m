From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 20 Apr 2016 10:44:01 +0200
Subject: [PATCH v2 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <20160419212944.GF15324@codeaurora.org>
References: <1460973696-5977-1-git-send-email-narmstrong@baylibre.com>
 <1460973696-5977-2-git-send-email-narmstrong@baylibre.com>
 <20160419212944.GF15324@codeaurora.org>
Message-ID: <57174151.8040806@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 04/19/2016 11:29 PM, Stephen Boyd wrote:
> On 04/18, Neil Armstrong wrote:
>> +
>> +static int oxnas_stdclk_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct clk_oxnas_data *clk_oxnas;
>> +	struct regmap *regmap;
>> +	int i;
>> +
>> +	clk_oxnas = devm_kzalloc(&pdev->dev, sizeof(*clk_oxnas), GFP_KERNEL);
>> +	if (!clk_oxnas)
>> +		return -ENOMEM;
>> +
>> +	regmap = syscon_node_to_regmap(of_get_parent(np));
>> +	if (!regmap) {
>> +		dev_err(&pdev->dev, "failed to have parent regmap\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(clk_oxnas_init); i++) {
>> +		struct clk_oxnas *_clk;
>> +
>> +		if (!clk_oxnas_init[i].clk_init)
>> +			continue;
> 
> New design is fine, really it's up to you, but then this check
> isn't needed anymore, right?
> 

it's not needed for sure, but do I need to send a v3 to remove this ?

Neil
