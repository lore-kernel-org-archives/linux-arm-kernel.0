From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 14:36:28 -0800
Subject: [PATCH 02/10] qcom: scm: Add SCM warmboot support for quad core
 SoCs
In-Reply-To: <1417040910-43290-3-git-send-email-lina.iyer@linaro.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org>
 <1417040910-43290-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <547655EC.2040401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
> warm boot addresses in the Secure Monitor. Extend the SCM flags to
> support warm boot addresses for secondary cores.
>
> We do not need to export the warmboot flags. Move them into the
> implementation file.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> @@ -37,3 +54,20 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>   			&cmd, sizeof(cmd), NULL, 0);
>   }
>   EXPORT_SYMBOL(scm_set_boot_addr);
> +
> +int scm_set_warm_boot_addr(void *entry, int cpu)
> +{
> +	int ret;
> +
> +	/* Reassign only if we are switching from hotplug entry point
> +	 * to cpuidle entry point or vice versa.
> +	 */

Multi-line comments are like this:

/*
  * Reassign only if we are ...
  */


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
