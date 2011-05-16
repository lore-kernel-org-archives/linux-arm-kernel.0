From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 16 May 2011 21:19:00 +0100
Subject: [PATCH v2] regulator: mc13892: Fix voltage unit in test case.
In-Reply-To: <1305554067-20643-1-git-send-email-fabio.estevam@freescale.com>
References: <1305554067-20643-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1305577140.3156.13.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 10:54 -0300, Fabio Estevam wrote:
> Voltage values should be expressed in microvolts, not in milivolts.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> Changes since v1:
> 
> - Rebase it on top of Liam's regulator for-next tree.
>  
>  drivers/regulator/mc13892-regulator.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
> index 73347c8..6fffe67 100644
> --- a/drivers/regulator/mc13892-regulator.c
> +++ b/drivers/regulator/mc13892-regulator.c
> @@ -453,9 +453,9 @@ static int mc13892_sw_regulator_set_voltage(struct regulator_dev *rdev,
>  	if (ret)
>  		goto err;
>  
> -	if (value > 1375)
> +	if (value > 1375000)
>  		hi = 1;
> -	else if (value < 1100)
> +	else if (value < 1100000)
>  		hi = 0;
>  	else
>  		hi = valread & MC13892_SWITCHERS0_SWxHI;

Applied.
