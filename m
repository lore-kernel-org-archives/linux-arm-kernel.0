From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Nov 2012 16:46:23 -0800
Subject: [PATCH v5 03/10] pinctrl: append method of lookup pinctrl map
In-Reply-To: <1352968600-15345-4-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121117004622.GP6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121115 00:39]:
> --- a/include/linux/pinctrl/consumer.h
> +++ b/include/linux/pinctrl/consumer.h
> @@ -36,6 +36,10 @@ extern struct pinctrl_state * __must_check pinctrl_lookup_state(
>  							struct pinctrl *p,
>  							const char *name);
>  extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
> +extern const struct pinctrl_map * __must_check pinctrl_lookup_map(
> +						struct pinctrl *p,
> +						const char *name,
> +						unsigned type);
>  
>  extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
>  extern void devm_pinctrl_put(struct pinctrl *p);

I think this should be in drivers/pinctrl/core.h, or is there
a need for the consumer drivers to use this?

Regards,

Tony
