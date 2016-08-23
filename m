From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 23 Aug 2016 14:44:57 +0100
Subject: [PATCH v3 06/12] soc/tegra: Add Tegra186 support
In-Reply-To: <20160819173233.13260-7-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-7-thierry.reding@gmail.com>
Message-ID: <3211799e-5f21-0294-1530-c76ca2b926dc@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/08/16 18:32, Thierry Reding wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> The Tegra186 has a combination of Denver and Cortex-A57 CPU cores and
> GPUs with Pascal architecture on it. It features with ADSP with
> Cortex-A9 CPU for audio processing, hardware video encoder/decoder with
> multi-format support, ISP for image capture processing and BPMP for the
> power managements.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/Kconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
> index 03089ad2fc65..88a71dfd466c 100644
> --- a/drivers/soc/tegra/Kconfig
> +++ b/drivers/soc/tegra/Kconfig
> @@ -61,6 +61,20 @@ config ARCH_TEGRA_132_SOC
>  	  but contains an NVIDIA Denver CPU complex in place of
>  	  Tegra124's "4+1" Cortex-A15 CPU complex.
>  
> +config ARCH_TEGRA_186_SOC
> +	bool "NVIDIA Tegra186 SoC"
> +	select MAILBOX
> +	select TEGRA_BPMP
> +	select TEGRA_HSP_MBOX
> +	select TEGRA_IVC
> +	help
> +	  Enable support for the NVIDIA Tegar186 SoC. The Tegra186 has a
> +	  combination of Denver and Cortex-A57 CPU cores and GPUs with Pascal
> +	  architecture on it. It features with ADSP with Cortex-A9 CPU for
> +	  audio processing, hardware video encoder/decoder with multi-format
> +	  support, ISP for image capture processing and BPMP for the power
> +	  managements.
> +
>  config ARCH_TEGRA_210_SOC
>  	bool "NVIDIA Tegra210 SoC"
>  	select PINCTRL_TEGRA210
> 

After this patch is applied, if I say Y to enable Tegra186 support then I get ...

drivers/built-in.o: In function `tegra_bpmp_probe':
/home/jonathanh/workdir/tegra/korg-linux-next.git/drivers/firmware/tegra/bpmp.c:820: undefined reference to `tegra_bpmp_init_clocks'
/home/jonathanh/workdir/tegra/korg-linux-next.git/drivers/firmware/tegra/bpmp.c:824: undefined reference to `tegra_bpmp_init_resets'

It seems that patches 11 and 12 should be applied before patch 5 of this series or am I overlooking something? 

Jon

-- 
nvpublic
