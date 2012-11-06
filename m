From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 10:09:11 +0000
Subject: [PATCH 3/8] ARM: OMAP: AM33xx hwmod: Add parent-child
 relationship for PWM subsystem
In-Reply-To: <1352106749-9437-4-git-send-email-avinashphilip@ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-4-git-send-email-avinashphilip@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC049D9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 14:42:24, Philip, Avinash wrote:
[...]

> +
> +static struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
> +	.master		= &am33xx_epwmss0_hwmod,
> +	.slave		= &am33xx_ecap0_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.addr		= am33xx_ecap0_addr_space,
> +	.user		= OCP_USER_MPU,
> +};

Noticed this in another patch which is quite similar so commenting here
again. Is the user field required if you are just creating a parent-child
relationship here?

Regards,
Vaibhav 
