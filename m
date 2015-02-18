From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 21:38:19 +0100
Subject: [PATCH] ARM: make arrays containing machine compatible strings
 const
In-Reply-To: <1424289705-11786-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424289705-11786-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5808332.37GVWYAetI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 February 2015 21:01:45 Uwe Kleine-K?nig wrote:
> The definition
> 
>         static const char *axxia_dt_match[] __initconst = {
>                 ...
> 
> defines a changable array of constant strings. That is you must not do:
> 
>         *axxia_dt_match[0] = 'k';
> 
> but
> 
>         axxia_dt_match[0] = "different string";
> 
> is fine. So the annotation __initconst is wrong and yields a compiler
> error when other really const variables are added with __initconst.
> 
> As the struct machine_desc member dt_compat is declared as
> 
>         const char *const *dt_compat;
> 
> making the arrays const is the better alternative over changing all
> annotations to __initdata.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 


Applied to fixes branch, thanks!

	Arnd
