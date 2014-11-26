From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 11:48:24 -0800
Subject: [PATCH v10 02/10] qcom: scm: Add SCM warmboot support for quad
 core SoCs
In-Reply-To: <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <54762E88.50300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> @@ -37,3 +54,17 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>   			&cmd, sizeof(cmd), NULL, 0);
>   }
>   EXPORT_SYMBOL(scm_set_boot_addr);
> +
> +int scm_set_warm_boot_addr(void *entry, int cpu)
> +{
> +	int ret;
> +
> +	if (entry == scm_flags[cpu].entry)
> +		return 0;

Is the entry going to be different at some point? I wonder why we can't 
just call this function once when the SPM device probes to setup the 
entry point to cpu_resume()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
