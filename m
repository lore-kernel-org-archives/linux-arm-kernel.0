From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Nov 2014 09:44:10 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <1416213534.761947189@f70.i.mail.ru>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
 <1416213534.761947189@f70.i.mail.ru>
Message-ID: <20141117084410.GD27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexander,

On Mon, Nov 17, 2014 at 11:38:54AM +0300, Alexander Shiyan wrote:
> Hello.
> 
> ...
> > > struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> > > idx, int *irqs)
> > What is idx about? I see it already in the mctrl_gpio API, but there is
> > no documentation about how it's used. Is it always 0?
> 
> This could be used for drivers with several UARTs, which registered at once.
Then what about:

	/**
	 * Document what idx is about here.
	 */
	struct mctrl_gpios *mctrl_gpio_init_index(struct uart_port *port, unsigned int idx);
	static inline struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port)
	{
		return mctrl_gpio_init_index(port, 0);
	}

? That matches how gpio and of functions use the indexed variants.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
