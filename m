From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 12 Jul 2013 23:46:38 -0700
Subject: [PATCH v2 1/3] input: mc13783: Prepare driver to support MC13892
 and OF
In-Reply-To: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
References: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130713064638.GB20979@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Sat, Jul 13, 2013 at 08:25:49AM +0400, Alexander Shiyan wrote:
> +
> +	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++)
> +		if (priv->enabled & BIT(i)) {
> +			ret = mc13xxx_irq_request(priv->mc13xxx,
> +						  priv->devtype->btn_def[i].irq,
> +						  mc13xxx_pwrbutton_irq, NULL,
> +						  priv);
> +			if (!ret)
> +				continue;

I'd rather we continued requesting interrupts in probe() as opposed to
open(). I believe the driver should acquire all resources it needs when
binding, instead of later.

Thanks.

-- 
Dmitry
