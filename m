From: nm@ti.com (Nishanth Menon)
Date: Fri, 10 Oct 2014 08:43:09 -0500
Subject: [PATCH 2/2] regulator: twl: use platform data in the DT based
 boot also
In-Reply-To: <1412948442-19896-3-git-send-email-t-kristo@ti.com>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com>
 <1412948442-19896-3-git-send-email-t-kristo@ti.com>
Message-ID: <20141010134308.GA15977@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:40-20141010, Tero Kristo wrote:
> This allows to pass platform information during a DT boot also, currently
> this is completely ignored. Needed for supporting the platform specific
> regulator set_voltage / get_voltage ops for the SMPS regulators.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/twl-regulator.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 0b4f866..2c4fa06 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -1103,9 +1103,9 @@ static int twlreg_probe(struct platform_device *pdev)
>  	if (match) {
>  		template = match->data;
>  		id = template->desc.id;
> +		drvdata = dev_get_platdata(&pdev->dev);
>  		initdata = of_get_regulator_init_data(&pdev->dev,
>  						      pdev->dev.of_node);
> -		drvdata = NULL;
>  	} else {
>  		id = pdev->id;
>  		initdata = dev_get_platdata(&pdev->dev);
> -- 
> 1.7.9.5
> 

please post this separately and liam, mark need to be in cc.
Unfortunately, I think we might be pushed back with pdata should'nt be
in of boot.

So a slightly longer commit message might be necessary.

-- 
Regards,
Nishanth Menon
