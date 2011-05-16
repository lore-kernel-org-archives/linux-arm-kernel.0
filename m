From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 16 May 2011 13:17:28 +0100
Subject: [PATCH] regulator: mc13892: Fix voltage unit in test case.
In-Reply-To: <1305500025-3602-1-git-send-email-festevam@gmail.com>
References: <1305500025-3602-1-git-send-email-festevam@gmail.com>
Message-ID: <1305548248.3156.5.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-15 at 19:53 -0300, Fabio Estevam wrote:
> Voltage values should be expressed in microvolts, not in milivolts.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
> ---
>  drivers/regulator/mc13892-regulator.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
> index 6f15168..e90ba05 100644
> --- a/drivers/regulator/mc13892-regulator.c
> +++ b/drivers/regulator/mc13892-regulator.c
> @@ -453,9 +453,9 @@ static int mc13892_sw_regulator_set_voltage(struct regulator_dev *rdev,
>  		goto err;
>  
>  	hi  = val & MC13892_SWITCHERS0_SWxHI;
> -	if (value > 1375)
> +	if (value > 1375000)
>  		hi = 1;
> -	if (value < 1100)
> +	if (value < 1100000)
>  		hi = 0;
>  
>  	if (hi) {

This doesn't apply against the regulator for-next branch. Could you redo
and add Mark's Ack.

Thanks.

Liam 
