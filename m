From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Oct 2014 09:40:50 +0100
Subject: [PATCH 2/8] regulator: max77686: Remove support for board files
In-Reply-To: <20141028003709.GL18557@sirena.org.uk>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-3-git-send-email-k.kozlowski@samsung.com>
 <20141028003709.GL18557@sirena.org.uk>
Message-ID: <1414485650.24949.10.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-10-28 at 00:37 +0000, Mark Brown wrote:
> On Mon, Oct 27, 2014 at 04:03:40PM +0100, Krzysztof Kozlowski wrote:
> > The driver is used only on Exynos4 based boards with DTS support.
> > Convert the driver to DTS-only version.
> 
> This doesn't seem like a particularly persuasive reason honestly and if
> you're going to mess around with this stuff please fix it properly...
> 
> >  struct max77686_data {
> > +	struct max77686_regulator_data *regulators;
> > +	int num_regulators;
> > +
> 
> ...the only reason for this array and the specification of the number of
> regulators is to make platform data easier to do...
> 
> > -	pdata->num_regulators = ARRAY_SIZE(regulators);
> > +	max77686->num_regulators = ARRAY_SIZE(regulators);
> 
> ...and indeed we wind up with a constant here anyway.  At the very least
> it'd be better to pull the parsing into the registration, right now we
> have the code still laid out for platform data so it's hard to see it as
> a win in cleanup terms.  If we're not translating into platform data we
> shouldn't need to keep this stuff around outside of the probe function.
> 
> What would be even better would be to convert to use the standard DT
> parsing with regulators_node and of_match specified in the descriptor
> and then delete most of this code entirely.

You're right, there's a lot to clean in this driver.

The only caveat is that I can't test the max77802 regulator so I
refrained from doing intrusive changes to it. I'll try to clean up both
drivers and make max77802 as RFT.

Best regards,
Krzysztof
