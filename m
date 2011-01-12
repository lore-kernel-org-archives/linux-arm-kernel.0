From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 08:29:36 +0100
Subject: [PATCH 2/2] ARM i.MX53 enable LOCO board bootup
In-Reply-To: <AANLkTimODoRu8JSOs5ChOp8i3LUoUP4ZKn=aDHnVU6pL@mail.gmail.com>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
	<1294726998-20830-3-git-send-email-yong.shen@freescale.com>
	<AANLkTimW54m2f+Z21F+9dLw78WOS24W4yc00D5rztM0C@mail.gmail.com>
	<AANLkTimODoRu8JSOs5ChOp8i3LUoUP4ZKn=aDHnVU6pL@mail.gmail.com>
Message-ID: <20110112072936.GW24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 10:46:24AM +0800, Yong Shen wrote:
> Hi Fabio,
> 
> Below is my reply to Baruch, I meant to keep this code here to show
> the reset process clearly.
> >> +     if (ret) {
> >> +             printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
> >> +             return;
> >> +     }
> >> +     gpio_direction_output(SMD_FEC_PHY_RST, 0);
> >> +     gpio_set_value(SMD_FEC_PHY_RST, 0);
> >
> > This seems to be redundant. gpio_direction_output() has already set the value
> > to 0.
> 
> You are right. But, gpio_set_value is meant to be here to show the
> process of fec reset: first pull low and then pull high. And
> gpio_direction_output here is for direction configuration although it
> has the ability of configure output value.
If you care about it:  I'd vote for removing the call to gpio_set_value,
too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
