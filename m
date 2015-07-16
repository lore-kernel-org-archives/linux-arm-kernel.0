From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 21:32:32 +0100
Subject: [PATCH 5/5] regulator: 88pm800: Add support for configuration of
 dual phase on BUCK1
In-Reply-To: <1437070618-21330-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437070618-21330-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150716203232.GA1602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:46:58PM +0530, Vaibhav Hiremath wrote:

>  	.disable		= regulator_disable_regmap,
>  	.is_enabled		= regulator_is_enabled_regmap,
>  	.get_current_limit	= pm800_get_current_limit,
> +	.set_current_limit	= pm800_set_current_limit,

set_current_limit() isn't the right interface to use for this, this is
something that depends on the physical design of the system rather than
something that limits the current.  It should be a DT property of its
own.  There are some other PMICs with similar functions but it's not
clear yet how generic the configuration mechanism is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/b5a98a6e/attachment.sig>
