From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:31:36 +0200
Subject: [PATCH v6 3/4] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <1404710376-16448-4-git-send-email-pankaj.dubey@samsung.com>
References: <1404710376-16448-1-git-send-email-pankaj.dubey@samsung.com>
 <1404710376-16448-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53BC00C8.4000204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

Just one comment I already had to previous version.

On 07.07.2014 07:19, Pankaj Dubey wrote:

[snip]

> -static void exynos5_init_pmu(void)
> +static void exynos5_powerdown_conf(enum sys_powerdown mode)
>  {
>  	unsigned int i;
>  	unsigned int tmp;
> @@ -382,51 +398,143 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>  {
>  	unsigned int i;
>  
> -	if (soc_is_exynos5250())
> -		exynos5_init_pmu();
> +	const struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
> +
> +	if (!pmu_data)
> +		return;

As I mentioned in my reply to previous version, I don't think there is
any point in probing this driver when there is no pmu_data. AFAIK the
generic syscon driver can take over in such case.

After fixing this, feel free to add

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
