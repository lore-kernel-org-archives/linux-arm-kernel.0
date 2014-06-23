From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 23 Jun 2014 09:45:51 +0000
Subject: [PATCH 2/5] regulator: act8865: set correct number of
 regulators in pdata
In-Reply-To: <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A2436419D1B5CB1@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Beniamino Galvani [mailto:b.galvani at gmail.com]
> Sent: Sunday, June 22, 2014 11:32 PM
> To: Liam Girdwood; Mark Brown
> Cc: Yang, Wenyou; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Heiko Stuebner; devicetree at vger.kernel.org; linux-
> doc at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Beniamino Galvani
> Subject: [PATCH 2/5] regulator: act8865: set correct number of
> regulators in pdata
> 
> When platform data is populated from DT all the regulators are
> instantiated and the value of num_regulators should be the number of
> all available regulators rather than the number of matched ones.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/regulator/act8865-regulator.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/act8865-regulator.c
> b/drivers/regulator/act8865-regulator.c
> index fe2c038..b03a0e8 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -230,7 +230,7 @@ static int act8865_pdata_from_dt(struct device *dev,
>  	if (!pdata->regulators)
>  		return -ENOMEM;
> 
> -	pdata->num_regulators = matched;
> +	pdata->num_regulators = ARRAY_SIZE(act8865_matches);
>  	regulator = pdata->regulators;
> 
>  	for (i = 0; i < ARRAY_SIZE(act8865_matches); i++) {
> --
> 1.7.10.4


Tested on at91-sama5d3_xplained with ACT8865

Tested-by Wenyou.Yang <wenyou.yang@atmel.com>

Best Regards,
Wenyou Yang
