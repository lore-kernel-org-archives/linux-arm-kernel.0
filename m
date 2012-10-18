From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:41:25 -0600
Subject: [PATCH 2/5] ARM: tegra: dts: add slink controller dt entry
In-Reply-To: <1350557795-31487-3-git-send-email-ldewangan@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <50808595.8070505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 04:56 AM, Laxman Dewangan wrote:
> Add slink controller details in the dts file of
> Tegra20 and Tegra30.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	slink at 7000d400 {
> +		compatible = "nvidia,tegra20-slink";
> +		reg = <0x7000d400 0x200>;
> +		interrupts = <0 59 0x04>;
> +		nvidia,dma-req-sel = <15>;

I thought the common DT DMA bindings were going to be in 3.7, and hence
we could just use them here rather than inventing another custom
property for this purpose?
