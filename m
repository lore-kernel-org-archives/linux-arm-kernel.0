From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 29 May 2013 18:11:51 -0400
Subject: [PATCH] thermal: step_wise: cdev only needs update on a new target
 state
In-Reply-To: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
References: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51A67D27.9050502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rui,

On 28-05-2013 02:55, Shawn Guo wrote:
> The cooling device only needs update on a new target state.  Since we
> already check old target in thermal_zone_trip_update(), we can do one
> more check to see if it's a new target state.  If not, we can reasonably
> save some uncecesary code execution.
> 

typo above:
s/uncecesary/unnecessary

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

A part from the above typo, I believe we must have this change in:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>  drivers/thermal/step_wise.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 4d4ddae..0afbd86 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -133,6 +133,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  		old_target = instance->target;
>  		instance->target = get_target_state(instance, trend, throttle);
>  
> +		if (old_target == instance->target)
> +			continue;
> +
>  		/* Activate a passive thermal instance */
>  		if (old_target == THERMAL_NO_TARGET &&
>  			instance->target != THERMAL_NO_TARGET)
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/34c0cea2/attachment.sig>
