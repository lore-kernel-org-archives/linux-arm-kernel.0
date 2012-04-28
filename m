From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 28 Apr 2012 13:01:08 +0200
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <20120428095222.GP24211@n2100.arm.linux.org.uk>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk>
 <4F992369.2020308@st.com>
 <20120428095222.GP24211@n2100.arm.linux.org.uk>
Message-ID: <20120428110108.GD20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 10:52:22AM +0100, Russell King - ARM Linux wrote:
> +
> +/**
> + * clk_register_clkdev - register one clock lookup for a struct clk
> + * @clk: struct clk to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_id: format string describing device name
> + *
> + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> + * clkdev.
> + *
> + * To make things easier for mass registration, we detect the NULL clk
> + * from a previous clk_register() call, and generate an error code for
> + * that.  This is to permit this function to be called immediately after
> + * clk_register().
> + */
> +int clk_register_clkdev(struct clk *clk, const char *con_id,
> +	const char *dev_fmt, ...)
> +{
> +	struct clk_lookup *cl;
> +	va_list ap;
> +
> +	if (!clk)
> +		return -ENOMEM;

clk_register was recently changed to return ERR_PTR in Mikes branch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
