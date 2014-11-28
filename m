From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 11:21:16 +0000
Subject: [PATCH v4 2/7] regulator: dt-bindings: Document the ena-gpios
 property
In-Reply-To: <1417165784.18249.15.camel@AMDC1943>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-3-git-send-email-k.kozlowski@samsung.com>
 <20141127183058.GB7712@sirena.org.uk>
 <1417165784.18249.15.camel@AMDC1943>
Message-ID: <20141128112116.GG7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 10:09:44AM +0100, Krzysztof Kozlowski wrote:

> I understand your concerns here however I didn't want to overengineer
> this. Is the same GPIO (on more complex PMICs) used in different
> contexts? Like enable control and something more in the same time?

Yes, and it's often reprogrammable at runtime.

> Something like:
>  struct regulator_desc desc {
>  	.name		= "LDO1
>  	.of_match	= of_match_ptr("LDO1"),
>  	.regulators_node = of_match_ptr("voltage-regulators"),
>  	.ops		= &max77686_ldo_ops,
> +	.of_ena_gpio	= of_match_ptr("ena-gpios"),
>  ...
>  }

Yes, and note that this also means existing bindings can use the core
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/beefc92c/attachment.sig>
