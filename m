From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 10:51:08 -0700
Subject: [PATCH 1/5] ARM: DT: tegra114: add APB DMA controller DT entry
In-Reply-To: <1362750782-15174-2-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <513A250C.1000202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 06:52 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 has 32 channels APB DMA controller. Add DT entry for
> APB DMA controllers and make it compatible with "nvidia,tegra114-apbdma".

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	apbdma: dma {
> +		compatible = "nvidia,tegra114-apbdma";

So I know that the Tegra114 HW has a new channel-pause feature, which
the driver /can/ use. However, if the driver didn't know about that
feature, and continued to use the global-pause feature, would it still
work fine?

In other words, is the Tegra114 HW 100% backwards-compatible with the
Tegra30 HW, it's just that there are new features that SW could
optionally use?

If that is true, then we should also include "nvidia,tegra30-apbdma" in
the compatible value.
