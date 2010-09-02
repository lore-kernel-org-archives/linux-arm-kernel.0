From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 10:57:58 +0100
Subject: [PATCH 31/74] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <447e0086df5d9eac78a2fc4ccf7ad51ecbed0232.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<447e0086df5d9eac78a2fc4ccf7ad51ecbed0232.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902095758.GK26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:08:55PM +0530, Viresh KUMAR wrote:
> diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
> index 8658d48..8399c15 100644
> --- a/arch/arm/mach-spear13xx/clock.c
> +++ b/arch/arm/mach-spear13xx/clock.c
> @@ -799,7 +799,7 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{.dev_id = "i2s0",		.clk = &i2s0_clk},
>  	{.dev_id = "i2s1",		.clk = &i2s1_clk},
>  	{.dev_id = "adc",		.clk = &adc_clk},
> -	{.dev_id = "ssp",		.clk = &ssp_clk},
> +	{.dev_id = "ssp-pl022",		.clk = &ssp_clk},

All these kinds of changes are just noise in these patches, which add
to the review workload (and review tiredness.)  Your previous patches
added the original definitions.  Please roll these changes into your
previous patches so that there's less overall changes to look at in
your patch series.

It really is not necessary to show how you got from A to B via every
minute step.
