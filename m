From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Jun 2012 13:28:40 +0900
Subject: [PATCH 2/2] serial: samsung: Fixed wrong comparison for
 baudclk_rate
In-Reply-To: <000101cd3665$7943b690$6bcb23b0$%kim@samsung.com>
References: <000101cd3665$7943b690$6bcb23b0$%kim@samsung.com>
Message-ID: <028f01cd4e9d$2b344410$819ccc30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyoungil Kim wrote:
> 
> port->baudclk_rate should be compared to the rate of port->baudclk,
> because port->baudclk_rate was assigned as the rate of port->baudclk
> previously.
> So to check that the current baudclk rate is same as previous rate,
> the target of comparison sholud be the rate of port->baudclk.
> 
> Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>

(Cc'ed Greg)

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Greg, this is needed to fix the wrong comparison for baudclk_rate for
Samsung Serial.
Could you please pick this up in your fix tree?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/tty/serial/samsung.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 5668538..cefdd2d 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1013,10 +1013,10 @@ static int
> s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
>  	 * a disturbance in the clock-rate over the change.
>  	 */
> 
> -	if (IS_ERR(port->clk))
> +	if (IS_ERR(port->baudclk))
>  		goto exit;
> 
> -	if (port->baudclk_rate == clk_get_rate(port->clk))
> +	if (port->baudclk_rate == clk_get_rate(port->baudclk))
>  		goto exit;
> 
>  	if (val == CPUFREQ_PRECHANGE) {
> --
> 1.7.1
