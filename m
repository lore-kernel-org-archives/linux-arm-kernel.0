From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Oct 2014 09:52:36 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <544EA4FA.6040704@collabora.co.uk>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
 <544EA4FA.6040704@collabora.co.uk>
Message-ID: <1414486356.24949.19.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-10-27 at 21:03 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> > @@ -85,6 +91,9 @@ struct max77686_data {
> >  	struct max77686_regulator_data *regulators;
> >  	int num_regulators;
> >  
> > +	/* Array of size num_regulators with GPIOs for external control. */
> > +	int *ext_control_gpio;
> > +
> 
> The integer-based GPIO API is deprecated in favor of the descriptor-based GPIO
> interface (Documentation/gpio/consumer.txt). Could you please use the later?

Sure, I can. Please have in mind that regulator core still accepts old
GPIO so I will have to use desc_to_gpio(). That should work... and
should be future-ready.

Thanks for feedback,
Krzysztof

> 
> Best regards,
> Javier
