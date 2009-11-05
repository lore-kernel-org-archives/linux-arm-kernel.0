From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Nov 2009 19:28:18 +0100
Subject: [PATCH] Fix the machine description printing in __error_a
In-Reply-To: <20091105124149.27866.81631.stgit@pc1117.cambridge.arm.com>
References: <20091105124149.27866.81631.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091105182817.GC7221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 12:41:49PM +0000, Catalin Marinas wrote:
> Commit b86040a59f changed label 3 in head-common.S but only modified
> __lookup_machine_type. This patch corrects the __error_a function as
> well.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/kernel/head-common.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 885a721..b9505aa 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -97,7 +97,7 @@ __error_a:
>  	bl	printhex8
>  	adr	r0, str_a2
>  	bl	printascii
> -	adr	r3, 3f
> +	adr	r3, 4f
>  	ldmia	r3, {r4, r5, r6}		@ get machine desc list
>  	sub	r4, r3, r4			@ get offset between virt&phys
>  	add	r5, r5, r4			@ convert virt addresses to
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
