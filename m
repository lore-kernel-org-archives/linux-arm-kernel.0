From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Tue, 19 Jul 2011 10:59:49 +0530
Subject: [PATCH] davinci: fix DM365 EVM video input mux bits
In-Reply-To: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
References: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BCEF73E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon,

The fix looks correct. As a part of a different implementation which will go soon upstream, this has been taken care of, where we have used macros 
CPLD_VIDEO_INPUT_MUX_TVP7002    0x1
CPLD_VIDEO_INPUT_MUX_IMAGER     0x2

So, if you can do the same, it will look better.

Thanks,
-Manju


On Tue, Jul 19, 2011 at 09:00:11, Jon Povey wrote:
> Video input mux settings for tvp7002 and imager inputs were swapped.
> Comment was correct.
> 
> Tested on EVM with tvp7002 input.
> 
> Signed-off-by: Jon Povey <jon.povey@racelogic.co.uk>
> ---
> As a bugfix maybe this should try to get into 3.0?
> 
>  arch/arm/mach-davinci/board-dm365-evm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index c67f684..09a87e6 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -520,7 +520,7 @@ fail:
>  	 */
>  	if (have_imager()) {
>  		label = "HD imager";
> -		mux |= 1;
> +		mux |= 2;
>  
>  		/* externally mux MMC1/ENET/AIC33 to imager */
>  		mux |= BIT(6) | BIT(5) | BIT(3);
> @@ -540,7 +540,7 @@ fail:
>  		resets &= ~BIT(1);
>  
>  		if (have_tvp7002()) {
> -			mux |= 2;
> +			mux |= 1;
>  			resets &= ~BIT(2);
>  			label = "tvp7002 HD";
>  		} else {
> --
> 1.6.3.3
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
