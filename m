From: khilman@ti.com (Kevin Hilman)
Date: Wed, 31 Aug 2011 15:24:46 -0700
Subject: [PATCH 3/7] OMAP3: beagle-board: Use the omap_hwmod_name_get_dev
	API
In-Reply-To: <1314026347-21623-4-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:03 +0200")
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-4-git-send-email-b-cousson@ti.com>
Message-ID: <87mxep8bip.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Replace the multiple omap2_get_XXX_device APIs with the new
> omap_hwmod_name_get_dev that uses the hwmod name to get the proper
> device.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 3ae16b4..dab16e0 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -493,8 +493,8 @@ static void __init beagle_opp_init(void)
>  	if (cpu_is_omap3630()) {
>  		struct device *mpu_dev, *iva_dev;
>  
> -		mpu_dev = omap2_get_mpuss_device();
> -		iva_dev = omap2_get_iva_device();
> +		mpu_dev = omap_hwmod_name_get_dev("mpu");
> +		iva_dev = omap_hwmod_name_get_dev("iva");
>  
>  		if (!mpu_dev || !iva_dev) {
>  			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",

Looks fine.

Kevin
