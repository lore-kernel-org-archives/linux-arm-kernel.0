From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 13:33:55 +0200
Subject: [PATCH 34/40] ARM: imx6: implement clocks using common clock
 framework
In-Reply-To: <1334065553-7565-35-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-35-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120418113355.GO20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> +
> +static const char * const clks_init_on[] __initconst = {
> +	"mmdc_ch0_axi", "mmdc_ch1_axi", "uart_ipg", "uart_serial",
> +};

I assume uart_ipg and uart_serial is here for the earlyprintk case. This
is not needed anymore. earlyprintk depends on an enabled uart anyway, so
we can safely assume that the clock is turned on when Linux starts. The
clock framework will disable the clock in a late initcall, long after
the real driver has taken over and enabled the clock.

I'll fix that on my side.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
