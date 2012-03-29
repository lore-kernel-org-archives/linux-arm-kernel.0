From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 23:03:42 +0100
Subject: [PATCH v5 04/16] pwm: Add table-based lookup for static mappings
In-Reply-To: <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120329220342.GK4153@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:46PM +0200, Thierry Reding wrote:

> +	static struct pwm_lookup board_pwm_lookup[] = {
> +		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight"),
> +	};

The clock and regulator APIs namespace the consumers by struct device -
might this not be sensible here?  pwm_get() does already take the device
as an argument.  It'd feel safer, and for example there's plenty of
phones out there with two backlit displays...

> + * pwm_get() - look up and request a PWM device
> + * @dev: device for PWM consumer
> + * @provider: name of provider PWM chip
> + * @index: per-chip index of PWM to request

The documentation is out of sync with the signature.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/afdf521d/attachment.sig>
