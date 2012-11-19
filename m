From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 19 Nov 2012 07:53:00 +0100
Subject: [PATCH 2/2] pwm: vt8500: Ensure pwm clock is enabled during
 pwm_config
In-Reply-To: <1353290780-19413-3-git-send-email-linux@prisktech.co.nz>
References: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
 <1353290780-19413-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121119065300.GD21890@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 03:06:20PM +1300, Tony Prisk wrote:
> When all PWMs are disabled, PWM module may be disabled during
> calls to pwm_config. This patch enables/disables the clock in
> pwm_config to ensure the module is active before register read/
> writes.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/pwm/pwm-vt8500.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
> index 806f72c..cc97af9 100644
> --- a/drivers/pwm/pwm-vt8500.c
> +++ b/drivers/pwm/pwm-vt8500.c
> @@ -63,6 +63,8 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned long period_cycles, prescale, pv, dc;
>  
> +	clk_enable(vt8500->clk);

This needs a check of the return value. Other than that, looks good.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/5159c5ec/attachment.sig>
