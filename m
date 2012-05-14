From: s.hauer@pengutronix.de (Buddhi)
Date: Mon, 14 May 2012 09:29:34 +0200
Subject: [PATCH 1/1] ARM: imx6q: prepare and enable init on clks directly
 instead of clk_get first
In-Reply-To: <1336971887-24616-1-git-send-email-richard.zhao@freescale.com>
References: <1336971887-24616-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120514072934.GA21318@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 01:04:47PM +0800, Richard Zhao wrote:
> This also makes any clk be possible init on.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

This is something I forgot to fix, thanks for doing this.

>  
> +static enum mx6q_clks const clks_init_on[] __initconst = {
> +	mmdc_ch0_axi, mmdc_ch1_axi, usboh3,
> +};

BTW, why usboh3? Do we need this? Right now we do not have USB support
on i.MX6. Once we have it the clock should be turned on in the USB
driver, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
