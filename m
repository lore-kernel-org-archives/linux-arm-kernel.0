From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 21 Jun 2011 17:00:41 +0530
Subject: [PATCH 6/6] arm: exynos4: Add a new Exynos4 device tree enabled
	machine
In-Reply-To: <BANLkTinaXg+_4xQiMCUw-aeGFeZs1iNuCQ@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-7-git-send-email-thomas.abraham@linaro.org>
	<BANLkTinaXg+_4xQiMCUw-aeGFeZs1iNuCQ@mail.gmail.com>
Message-ID: <BANLkTi=OVkGVP-FJkjHbd9tLuQE9gAFP9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2011 22:25, Grant Likely <grant.likely@secretlab.ca> wrote:

<snip>

>> +
>> +static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
>> + ? ? ? OF_DEV_AUXDATA("samsung,s3c-sdhci", EXYNOS4_PA_HSMMC(2),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "s3c-sdhci.2", &s3c_hsmmc2_def_platdata),
>> + ? ? ? OF_DEV_AUXDATA("samsung,s3c-sdhci", EXYNOS4_PA_HSMMC(0),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "s3c-sdhci.0", &s3c_hsmmc0_def_platdata),
>> + ? ? ? OF_DEV_AUXDATA("samsung,s5pv210-uart", S5P_PA_UART0,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "s5pv210-uart.0", NULL),
>> + ? ? ? OF_DEV_AUXDATA("samsung,s5pv210-uart", S5P_PA_UART1,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "s5pv210-uart.1", NULL),
>> + ? ? ? {},
>> +};

<snip>

>> +static void __init exynos4_dt_machine_init(void)
>> +{
>> + ? ? ? s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
>> + ? ? ? s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
>
> Are these two lines still necessary?

Yes, but these are temporary. The data from smdkv310_hsmmc0_pdata is
copied to s3c_hsmmc2_def_platdata which is then used as platform data.
I will remove them in the next version of the patch.

Thanks,
Thomas.

>
> Otherwise, the patch looks good to me.
>
> g.
