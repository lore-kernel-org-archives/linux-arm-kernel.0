From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Nov 2013 14:34:18 +0100
Subject: [PATCH v2 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <20131121122011.GD23067@lee--X1>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-2-git-send-email-k.kozlowski@samsung.com>
 <20131121103408.GA22536@lee--X1> <1385034199.748.21.camel@AMDC1943>
 <20131121122011.GD23067@lee--X1>
Message-ID: <1385040858.748.27.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-11-21 at 12:20 +0000, Lee Jones wrote:
(...)
> > > > +struct max14577_regulator_platform_data {
> > > > +	int id;
> > > > +	struct regulator_init_data *initdata;
> > > > +	struct device_node *of_node;
> > > 
> > > Do you ever set this? What's the point of it is it's set in the device?
> > 
> > Do you mean the whole struct max14577_regulator_platform_data or only
> > some member of it (of_node?)?
> 
> Initially only the of_node. Usually MFD children are able to call back
> into their parent to fetch these details. Also mfd_add_device() goes
> out of its way to fill in the child's own of_node.

The of_node is needed for regulator driver. It is passed in struct regulator_config
to devm_regulator_register():
	config.of_node = pdata->regulators[i].of_node;
	info->regulators[i] = devm_regulator_register(&pdev->dev,
	                              &supported_regulators[id], &config);


Best regards,
Krzysztof
