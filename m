From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 13:20:30 +0200
Subject: [PATCH v4 15/17] pwm: sti: It's now valid for number of PWM
 channels to be zero
In-Reply-To: <20160816093508.28307-16-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-16-lee.jones@linaro.org>
Message-ID: <20160905112030.GO31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:06AM +0100, Lee Jones wrote:
> Setting up the STI PWM IP as capture only, with zero PWM-out devices
> is a perfectly valued configuration.  It is no longer okay to assume
> that there must be at least 1 PWM-out devices.  In this patch we make
> the default number of PWM-out devices zero and only configure channels
> explicitly requested.
> 
> Reported-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index fcc80eb..a1319c0 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -483,6 +483,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	if (!ret)
>  		cdata->cpt_num_devs = num_devs;
>  
> +	if (cdata->pwm_num_devs && !cdata->cpt_num_devs) {

Applied, with this corrected to:

	if (!cdata->pwm_num_devs && !cdata->cpu_num_devs)

as discussed on IRC.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/716dd476/attachment.sig>
