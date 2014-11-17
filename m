From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 17 Nov 2014 22:32:18 +0100
Subject: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <546A6962.9090801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2014 01:40 AM, Lina Iyer wrote:

Hi Lina,

[ ... ]

> +static inline void spm_register_write(struct spm_driver_data *drv,
> +					enum spm_reg reg, u32 val)
> +{
> +	if (drv->reg_data->reg_offset[reg])
> +		writel_relaxed(val, drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);

Why not use writel and don't use 'wmb' below ?

> +}
> +

[ ... ]

> +	spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
> +
> +	/* Ensure we have written the start address */
> +	wmb();



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
