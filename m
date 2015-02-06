From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 6 Feb 2015 20:21:21 +0100
Subject: [PATCH] pinctrl: imx: do not implicitly set pin regs to -1
In-Reply-To: <1423240256-27210-1-git-send-email-stefan@agner.ch>
References: <1423240256-27210-1-git-send-email-stefan@agner.ch>
Message-ID: <20150206192121.GD10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Stefan,

On Fri, Feb 06, 2015 at 05:30:56PM +0100, Stefan Agner wrote:
> -	memset(info->pin_regs, 0xff, sizeof(*info->pin_regs) * info->npins);
> +
> +	for (i = 0; i < info->npins; i++) {
> +		info->pin_regs[i].mux_reg = -1;
> +		info->pin_regs[i].conf_reg = -1;
> +	}
looks definitely better. Just out of interest, did you check if it
changes the generated code?

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
