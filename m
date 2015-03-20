From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Mar 2015 17:23:54 +0000
Subject: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used
 for DT
In-Reply-To: <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20150320172353.GJ3421@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 01:29:33PM +0100, Daniel Lezcano wrote:
> diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> index 0710654..1bee287 100644
> --- a/arch/arm64/include/asm/cpuidle.h
> +++ b/arch/arm64/include/asm/cpuidle.h
> @@ -15,5 +15,8 @@ static inline int cpu_suspend(unsigned long arg)
>  	return -EOPNOTSUPP;
>  }
>  #endif
> -
> +static inline int arm_cpuidle_suspend(int index)
> +{
> +	return cpu_suspend(index);
> +}
>  #endif

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
