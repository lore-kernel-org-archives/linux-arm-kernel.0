From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Nov 2011 14:10:22 +0100
Subject: [PATCH 2/2] ARM: amba: Auto-generate AMBA driver module aliases
 during modpost
In-Reply-To: <1321872510-2562-3-git-send-email-dave.martin@linaro.org>
References: <1321872510-2562-1-git-send-email-dave.martin@linaro.org>
 <1321872510-2562-3-git-send-email-dave.martin@linaro.org>
Message-ID: <20111121131022.GE30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dave,

On Mon, Nov 21, 2011 at 10:48:30AM +0000, Dave Martin wrote:
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -52,7 +52,14 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	int retval = 0;
>  
>  	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
> -	return retval;
> +	if (retval)
> +		return retval;
> +
> +	retval = add_uevent_var(env, "MODALIAS=amba:d%08X", pcdev->periphid);
> +	if (retval)
> +		return retval;
> +
> +	return 0;
Just return retval here?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
