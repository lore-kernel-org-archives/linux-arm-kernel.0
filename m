From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 29 Jan 2016 01:20:08 +0000
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <20160129001603.GM4130@sirena.org.uk>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: 2016?1?29? 8:16
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> Pawel Moll <pawel.moll@arm.com>; Ian Campbell
> <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> Krzysztof Kozlowski <k.kozlowski@samsung.com>; Javier Martinez Canillas
> <javier@dowhile0.org>; Lee Jones <lee.jones@linaro.org>; Peter Korsgaard
> <jacmet@gmail.com>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
> ACT8945A
> 
> On Wed, Jan 27, 2016 at 10:57:42AM +0800, Wenyou Yang wrote:
> 
> > +static const struct of_device_id act8945a_pmic_of_match[] = {
> > +	{ .compatible = "active-semi,act8945a-regulator" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, act8945a_pmic_of_match);
> 
> This seems mostly OK but why do we have a compatible string here - shouldn't
> the MFD be able to instantiate the regulator function without needing this?

Because I got feedback from Javier for the act8945a-charger patches of this MFD series,
He said missing the OF match table will cause the module autoloading broken. 

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398113.html

What do you think about it?


Best Regards,
Wenyou Yang
