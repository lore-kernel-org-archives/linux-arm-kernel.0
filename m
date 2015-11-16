From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Nov 2015 10:55:58 +0000
Subject: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx()
 helpers where appropriate
In-Reply-To: <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151116105558.GB31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:

> +++ b/drivers/regulator/pwm-regulator.c
> @@ -56,7 +56,7 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
>  	int dutycycle;
>  	int ret;
>  
> -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
>  
>  	dutycycle = (pwm_reg_period *
>  		    drvdata->duty_cycle_table[selector].dutycycle) / 100;

It's not clear to me that we're not looking for the current period here
or in the other use.  Won't configuring based on a period other than the
one that has been set give the wrong answer?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151116/24b079fa/attachment-0001.sig>
