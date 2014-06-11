From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Jun 2014 11:02:03 -0400
Subject: [PATCH v2] ARM: mvebu: Don't apply the thermal quirk if the
 SoC revision is unknown
In-Reply-To: <1402425283-24989-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1402425283-24989-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140611150203.GR8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 03:34:43PM -0300, Ezequiel Garcia wrote:
...
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 594262b..c94caa1 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -119,8 +119,16 @@ static void __init thermal_quirk(void)
>  {
>  	struct device_node *np;
>  	u32 dev, rev;
> +	int res;
>  
> -	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
> +	/*
> +	 * The early SoC Z1 revision needs a quirk to be applied in order
> +	 * for the thermal controller to work properly. This quirk breaks
> +	 * the thermal support if applied on a SoC that doesn't need it,
> +	 * so we enforce the SoC revision to be known.

nit: "so we apply the quirk iff the SoC revision is known."

thx,

Jason.
