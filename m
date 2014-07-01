From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 1 Jul 2014 15:14:52 +0300
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <8761jh9sxv.fsf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thierry Reding <thierry.reding@gmail.com> writes:

> diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
> new file mode 100644
> index 000000000000..6b1617ce022f
> --- /dev/null
> +++ b/include/dt-bindings/memory/tegra124-mc.h
> @@ -0,0 +1,30 @@
> +#ifndef DT_BINDINGS_MEMORY_TEGRA124_MC_H
> +#define DT_BINDINGS_MEMORY_TEGRA124_MC_H
> +
> +#define TEGRA_SWGROUP_DC       0
> +#define TEGRA_SWGROUP_DCB      1
> +#define TEGRA_SWGROUP_AFI      2
> +#define TEGRA_SWGROUP_AVPC     3
> +#define TEGRA_SWGROUP_HDA      4
> +#define TEGRA_SWGROUP_HC       5
> +#define TEGRA_SWGROUP_MSENC    6
> +#define TEGRA_SWGROUP_PPCS     7
> +#define TEGRA_SWGROUP_SATA     8
> +#define TEGRA_SWGROUP_VDE      9
> +#define TEGRA_SWGROUP_MPCORELP 10
> +#define TEGRA_SWGROUP_MPCORE   11
> +#define TEGRA_SWGROUP_ISP2     12
> +#define TEGRA_SWGROUP_XUSB_HOST        13
> +#define TEGRA_SWGROUP_XUSB_DEV 14
> +#define TEGRA_SWGROUP_ISP2B    15
> +#define TEGRA_SWGROUP_TSEC     16
> +#define TEGRA_SWGROUP_A9AVP    17
> +#define TEGRA_SWGROUP_GPU      18
> +#define TEGRA_SWGROUP_SDMMC1A  19
> +#define TEGRA_SWGROUP_SDMMC2A  20
> +#define TEGRA_SWGROUP_SDMMC3A  21
> +#define TEGRA_SWGROUP_SDMMC4A  22
> +#define TEGRA_SWGROUP_VIC      23
> +#define TEGRA_SWGROUP_VI       24
> +
> +#endif

In the SMMUv8 patch series, I have assigned unique IDs for all those
HWAs among Tegra SoC generations so that DT can provide which HWAs are
attached to that SoC. The SMMUv8 driver would be unified among Tegra
SoCs, then.
