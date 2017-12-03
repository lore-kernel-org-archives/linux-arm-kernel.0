From: davem@davemloft.net (David Miller)
Date: Sun, 03 Dec 2017 18:21:49 -0500 (EST)
Subject: [PATCH net-next 2/2 v6] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171202110640.5284-2-linus.walleij@linaro.org>
References: <20171202110640.5284-1-linus.walleij@linaro.org>
 <20171202110640.5284-2-linus.walleij@linaro.org>
Message-ID: <20171203.182149.1898604535140297695.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat,  2 Dec 2017 12:06:40 +0100

> +struct gmac_txq {
> +	GMAC_TXDESC_T	*ring;

Please don't create struct based typedef's, express this using
a straight "struct gmac_rxdesc_t", and also make it lowercase.

Uppercase names are reserved for CPP macros, and this is how
visually one can determine if something is a CPP macro in the
kernel sources.

Please fix this for your entire submission.

> +struct gemini_ethernet_port {
> +	unsigned int id; /* 0 or 1 */

A value taking on only 0 or 1 can be stored in a smaller type
such as 'u8'

> +		for (i = 0; i < RX_STATS_NUM; ++i)

Please always express this in the canonical way which is
to increment the index using "i++" post-postdecrement.

Please fix this for your entire submission.

> +static irqreturn_t gemini_port_irq_thread(int irq, void *data)
> +{
> +	struct gemini_ethernet_port *port = data;
> +	struct gemini_ethernet *geth = port->geth;
> +	unsigned long irqmask = SWFQ_EMPTY_INT_BIT;
> +	unsigned long flags;

Always order local variables in reverse-christmas-tree format,
which is longest to shortest line.

Again, please fix this for your entire submission.

Thank you.
