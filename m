From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 28 Nov 2014 10:19:56 +0100
Subject: [PATCH v4 3/7] regulator: of: Parse ena-gpios property from DTS
In-Reply-To: <20141127184544.GD7712@sirena.org.uk>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-4-git-send-email-k.kozlowski@samsung.com>
 <20141127184544.GD7712@sirena.org.uk>
Message-ID: <1417166396.18249.16.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-11-27 at 18:45 +0000, Mark Brown wrote:
> On Thu, Nov 27, 2014 at 12:20:49PM +0100, Krzysztof Kozlowski wrote:
> 
> > +	constraints->ena_gpio = of_get_named_gpio_flags(np, "ena-gpios", 0,
> > +							&gpio_flags);
> > +	if (gpio_is_valid(constraints->ena_gpio)) {
> 
> No, this isn't sensible - in what way would an enable control GPIO be a
> constraint?  The whole reason we have separate constraint and config
> structures is that these are different things.  Keep the GPIO setup in
> the configuration.

OK, I'll change it to config.

Best regards,
Krzysztof
