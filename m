From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jun 2011 17:22:21 +0200
Subject: [PATCH 2/2] pwm: Add a i.MX23/28 pwm driver
In-Reply-To: <1309255368-9775-3-git-send-email-s.hauer@pengutronix.de>
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
	<1309255368-9775-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <201106281722.21600.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tuesday 28 June 2011, Sascha Hauer wrote:
> +
> +/* common register space */
> +static void __iomem *pwm_base_common;
> +#define REG_PWM_CTRL   0x0
> +#define PWM_SFTRST     (1 << 31)
> +#define PWM_CLKGATE    (1 << 30)
> +#define PWM_ENABLE(p)  (1 << (p))
> +

The driver looks pretty good overall, but the global pwm_base_common register
is rather ugly. I think this should really be passed down through resources
from  the platform device in one way or another.

	Arnd
