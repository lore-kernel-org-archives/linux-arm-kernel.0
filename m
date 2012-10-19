From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 12:13:33 -0700
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121019191333.GT4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:08]:
> Add pinconf generic support with POWER SOURCE, BIAS PULL.
...

> +	case PIN_CONFIG_POWER_SOURCE:
> +		if (pcs->psmask == PCS_OFF_DISABLED
> +			|| pcs->psshift == PCS_OFF_DISABLED)
> +			return -ENOTSUPP;
> +		data &= pcs->psmask;
> +		data = data >> pcs->psshift;
> +		*config = data;
> +		return 0;
> +		break;

Hmm, only slightly related to this patch, mostly a generic
question to others: Do others have any mux registers with
status bits for things like PIN_CONFIG_POWER_SOURCE?

I could use PIN_CONFIG_POWER_SOURCE for controlling the PBIAS
for omap MMC. But there's also a status bit that needs to be
checked for that. I think there was some other similar mux
register for USB PHY that has a status register.

So I'm wondering should the checking for status bit be handled
in the pinctrl consume driver? Or should we have some bindings
for that?

Regards,

Tony
