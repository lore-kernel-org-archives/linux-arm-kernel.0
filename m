From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Mar 2013 18:42:16 +0900
Subject: [PATCH 1/2] ARM: shmobile: kzm9g: correct smsc regulator
 registration
In-Reply-To: <1360936117-21765-2-git-send-email-horms+renesas@verge.net.au>
References: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
 <1360936117-21765-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130301094216.GI27938@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 10:48:36PM +0900, Simon Horman wrote:
> Correct the name of smsc devices used for regulator registration
> allowing the regulators to be found and used.
> 
> This eliminates the need for CONFIG_REGULATOR_DUMMY
> when CONFIG_REGULATOR is set.

Applied to the boards3 branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 1a26077..3cf5898 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -61,8 +61,8 @@
>  
>  /* Dummy supplies, where voltage doesn't matter */
>  static struct regulator_consumer_supply dummy_supplies[] = {
> -	REGULATOR_SUPPLY("vddvario", "smsc911x"),
> -	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
> +	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>  };
>  
>  /*
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
