From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Feb 2013 16:35:37 -0800
Subject: [PATCH v8 08/12] pinctrl: generic: dump pin configuration
In-Reply-To: <1359825953-15663-9-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130205003535.GB25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:30]:
> @@ -114,4 +116,10 @@ static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>  	return;
>  }
>  
> +static void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
> +					struct seq_file *s,
> +					unsigned long config)
> +{
> +	return;
> +}
>  #endif

This needs to be static inline void to avoid the following warning:

drivers/pinctrl/pinconf.h:122: warning: ?pinconf_generic_dump_config? defined but not used

Regards,

Tony
