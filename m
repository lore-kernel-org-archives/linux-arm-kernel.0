From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 22:47:18 +0100
Subject: [PATCH v5 05/16] pwm: Add device tree support
In-Reply-To: <1332945238-14897-6-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120329214717.GG4153@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:47PM +0200, Thierry Reding wrote:

> +	pwm-list ::= <single-pwm> [pwm-list]
> +	single-pwm ::= <pwm-phandle> <pwm-specifier>
> +	pwm-phandle : phandle to PWM controller node
> +	pwm-specifier : array of #pwm-cells specifying the given PWM
> +			(controller specific)

> +PWM properties should be named "pwms". The exact meaning of each pwms
> +property must be documented in the device tree binding for each device.
> +An optional property "pwm-names" may contain a list of strings to label
> +each of the PWM devices listed in the "pwms" property. If no "pwm-names"
> +property is given, the name of the user node will be used as fallback.

> +	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> +	if (IS_ERR(pwm))
> +		return ERR_PTR(-ENODEV);

It feels wrong to override the error code like this rather than passing
the error we got back to the caller.  Is there any great reason for
doing so?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/68e27476/attachment.sig>
