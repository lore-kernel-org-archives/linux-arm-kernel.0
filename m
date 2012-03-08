From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Mar 2012 15:06:07 +0000
Subject: [PATCH 05/11] tps6586x: Add device-tree support
In-Reply-To: <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120308150607.GP3638@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 03:51:25PM +0100, Thierry Reding wrote:

> +- gpio-controller: mark the device as a GPIO controller
> +- regulators: list of regulators provided by this controller, must be in the
> +  following order:
> +    SM0, SM1, SM2, LDO0, LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8, LDO9

This ordering requirement is fairly sad, if there are unused regulators
they still need to be listed even though...

> +			sm0_reg: sm0 {
> +				regulator-min-microvolt = < 725000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sm1_reg: sm1 {

...they all seem to be explicitly named in the device tree so presumably
there's enough information in there for the driver to pick any set of
regulators in any order.  This would be much nicer to use.

Otherwise this looks good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/3239a330/attachment.sig>
