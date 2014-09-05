From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Sep 2014 23:13:38 +0200 (CEST)
Subject: [PATCH V2 3/3] mfd: palmas: Add support for optional wakeup
In-Reply-To: <1409950311-25236-4-git-send-email-nm@ti.com>
References: <1409950311-25236-1-git-send-email-nm@ti.com>
 <1409950311-25236-4-git-send-email-nm@ti.com>
Message-ID: <alpine.DEB.2.10.1409052311210.5472@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Sep 2014, Nishanth Menon wrote:
> +	if (!palmas->wakeirq)
> +		goto no_wake_irq;
> +
> +	ret = devm_request_irq(palmas->dev, palmas->wakeirq,
> +			       palmas_wake_irq,
> +			       IRQF_ONESHOT | pdata->irq_flags,

Why is this marked IRQF_ONESHOT?

> +			       dev_name(palmas->dev),
> +			       &palmas);
> +	if (ret < 0)
> +		goto err_i2c;

Why err and not doing the obvious clearing of palmas->wakeirq and
keep at least the i2c functional?

Thanks,

	tglx
