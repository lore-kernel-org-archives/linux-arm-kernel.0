From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Sep 2014 23:48:12 +0200
Subject: [PATCH] clk: don't use __initconst for non-const arrays
In-Reply-To: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5412189C.2040802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Sylwester and removing my samsung.com e-mail which is no longer
valid]

On 11.09.2014 23:04, Uwe Kleine-K?nig wrote:
> The statement
> 
> 	static const char *name[];
> 
> defines a modifiable array of pointers to constant chars. That is
> 
> 	*name[0] = 'f';
> 
> is forbidden, but
> 
> 	name[0] = "f";
> 
> is not. So marking an array that is defined as above with __initconst is
> wrong. Either an additional const must be added such that the whole
> definition reads:
> 
> 	static const char *const name[] __initconst;
> 
> or where this is not possible __initdata must be used.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/clk/hisilicon/clk-hix5hd2.c |  6 ++--
>  drivers/clk/mxs/clk-imx23.c         | 12 ++++----
>  drivers/clk/mxs/clk-imx28.c         | 18 ++++++------
>  drivers/clk/rockchip/clk.h          |  2 +-
>  drivers/clk/samsung/clk-s5pv210.c   | 56 ++++++++++++++++++-------------------

For drivers/clk/samsung/*

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
