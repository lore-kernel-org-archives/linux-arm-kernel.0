From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Mon, 16 Apr 2012 22:56:55 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
Message-ID: <20120416205655.GJ20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 07:09:32PM +0530, viresh kumar wrote:
> On 4/16/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > Checking for NULL clk (or IS_ERR(clk)) and returning -ENOMEM does make
> > sense as I mentioned in my original proposal (it allows you to pass the
> > returned value from clk_register() directly to this function without
> > further checking, and you get the right error code.
> 
> V2:
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
> 
> With common clock framework, clks are allocated at runtime. Some of them require
> clkdevs to be allocated and added in global clkdev list.
> 
> This patch introduces helper routines to:
> 
>  - allocate and add single clkdev for a single clk structure.
>  - add multiple clkdevs for a single clk structure.
> 
> +
> +int clk_register_single_clkdev(struct clk *clk, const char *con_id,
> +		const char *dev_fmt, ...)

Can we drop the 'single' in the name? Otherwise it's quite a long
function name. I think name clk_register_clkdev makes it clear already
that we only register a single clkdev.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
