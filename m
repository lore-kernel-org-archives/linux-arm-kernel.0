From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Mar 2015 08:03:39 +0100
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <1426485311-31428-4-git-send-email-s.hauer@pengutronix.de>
References: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
 <1426485311-31428-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150316070339.GA25487@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

On Mon, Mar 16, 2015 at 06:55:09AM +0100, Sascha Hauer wrote:
> +static const char *axi_parents[] __initconst = {
> +	"clk26m",
> +	"syspll_d3",
> +	"syspll_d4",
> +	"syspll_d6",
> +	"univpll_d5",
> +	"univpll2_d2",
> +	"syspll_d3p5"
> +};
__initconst should only be used for const data, but this array isn't
const. Only the strings the pointer in this array point to are constant.

So you have to use either

	static const char *axi_parents[] __initdata = {

or

	static const char * const axi_parents[] __initconst = {

.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
