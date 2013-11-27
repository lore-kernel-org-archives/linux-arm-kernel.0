From: philippe.retornaz@gmail.com (=?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?=)
Date: Wed, 27 Nov 2013 16:58:33 +0100
Subject: [PATCH 1/3] pwm: Add mc13xxx pwm driver.
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Message-ID: <529616A9.2090909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> +struct mc13xxx *get_mc13xxx(void)
> +{
> +	return mc13xxx_data;
> +}
> +EXPORT_SYMBOL_GPL(get_mc13xxx);
> +
>   int mc13xxx_common_init(struct mc13xxx *mc13xxx,
>   		struct mc13xxx_platform_data *pdata, int irq)
>   {
> @@ -706,6 +714,9 @@ err_revision:
>   		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
>   	}
>
> +	/* Linux will not have to handle more than one mc13xxx pmic. */
> +	mc13xxx_data = mc13xxx;
> +

Why using a such hack instead of an MFD subdevice ?

Regards,

Philippe
