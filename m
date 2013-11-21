From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Nov 2013 15:27:13 +0100
Subject: [PATCH v2 4/5] regulator: max14577: Add regulator driver for Maxim
 14577
In-Reply-To: <3987325.g4jkYp0g0H@amdc1032>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-5-git-send-email-k.kozlowski@samsung.com>
 <3176793.htnYthLYeH@amdc1032> <3987325.g4jkYp0g0H@amdc1032>
Message-ID: <1385044033.748.29.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 18:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> Err..
> 
> > I'm missing something obvious "info" is redundant and can be removed
> > altogether.
> > 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> > > +	for (i = 0; i < pdata->num_regulators; i++) {
> > > +		int id = pdata->regulators[i].id;
> > > +
> > > +		config.init_data = pdata->regulators[i].initdata;
> > > +		config.of_node = pdata->regulators[i].of_node;
> > > +
> > > +		info->regulators[i] = devm_regulator_register(&pdev->dev,
> > > +				&supported_regulators[id], &config);
> > > +		if (IS_ERR(info->regulators[i])) {
> 
> This code actually reads from "info" but it can be fixed trivially
> to not require "info".

You're right, it can be removed. The info was a left-over from 3.10
where there isn't devm_regulator_register(). Thanks for review.


Best regards,
Krzysztof
