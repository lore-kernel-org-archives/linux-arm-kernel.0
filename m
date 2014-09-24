From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Sep 2014 22:01:04 -0700
Subject: [PATCH] ARM: make arrays containing machine compatible strings
 const
In-Reply-To: <1410470353-2685-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410470353-2685-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140924050104.GD24803@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 11:19:13PM +0200, Uwe Kleine-K??nig wrote:
> The definition
> 
> 	static const char *axxia_dt_match[] __initconst = {
> 		...
> 
> defines a changable array of constant strings. That is you must not do:
> 
> 	*axxia_dt_match[0] = 'k';
> 
> but
> 
> 	axxia_dt_match[0] = "different string";
> 
> is fine. So the annotation __initconst is wrong and yields a compiler
> error when other really const variables are added with __initconst.
> 
> As the struct machine_desc member dt_compat is declared as
> 
> 	const char *const *dt_compat;
> 
> making the arrays const is the better alternative over changing all
> annotations to __initdata.
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this is similar to the fix I sent earlier today which only fixed omap2.
> Does it make sense to split this patch per platform?


We should be fine applying it as-is. Applied to next/cleanup.


-Olof
