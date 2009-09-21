From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 21 Sep 2009 23:44:24 +0200
Subject: [PATCH 3/3] at91_can: add driver for Atmel's CAN controller on
	AT91SAM9263
In-Reply-To: <1253180254-11910-4-git-send-email-mkl@pengutronix.de>
References: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>
	<1253180254-11910-2-git-send-email-mkl@pengutronix.de>
	<1253180254-11910-3-git-send-email-mkl@pengutronix.de>
	<1253180254-11910-4-git-send-email-mkl@pengutronix.de>
Message-ID: <cd73a99e0909211444x70af0b73k3db99d1ab379913f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Marc,

> +static inline u32 at91_read(const struct at91_priv *priv, enum at91_reg reg)
> +{
> + ? ? ? return readl(priv->reg_base + reg);
> +}
> +
> +static inline void at91_write(const struct at91_priv *priv, enum at91_reg reg,
> + ? ? ? ? ? ? ? u32 value)
> +{
> + ? ? ? writel(value, priv->reg_base + reg);
> +}

Rather use __raw_readl() and __raw_writel().


Regards,
  Andrew Victor
