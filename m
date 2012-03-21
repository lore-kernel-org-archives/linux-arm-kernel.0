From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 21 Mar 2012 15:33:33 +0000
Subject: [PATCH v8 4/8] ARM: davinci: Consolidate time keeping and irq
 enable
In-Reply-To: <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800A07@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Mar 21, 2012 at 01:52:45, Robert Lee wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
> 
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Jean Pihet<j-pihet@ti.com>

>  static struct cpuidle_driver davinci_idle_driver = {
> -	.name	= "cpuidle-davinci",
> -	.owner	= THIS_MODULE,
> +	.name		= "cpuidle-davinci",
> +	.owner		= THIS_MODULE,
> +	.states[0]	= ARM_CPUIDLE_WFI_STATE,
> +	.states[1]	= {
> +		.enter			= davinci_enter_idle,
> +		.exit_latency		= 10,
> +		.target_residency	= 100000,

Apart from your other fix patch, can you also update the
target residency of this state to 10000 as is the case
with current code? With the new value the board is entering
this state really infrequently.

Thanks,
Sekhar
