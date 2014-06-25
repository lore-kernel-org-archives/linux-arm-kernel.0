From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jun 2014 13:11:20 +0200
Subject: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
In-Reply-To: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140625111119.GA21208@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 11:37:54AM +0100, Marc Zyngier wrote:
> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
> the current arm64 platforms.
> 
> Turns out that most of these platforms have described their GIC CPU
> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
> register lives at offset 0x1000).
> 
> This was found when converting the GIC driver to use EOImode==1 on
> GICv2-based systems. It uses the GICC_DIR register, and the result
> is a very early firework...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/axm55xx.dtsi              | 2 +-
>  arch/arm/boot/dts/dra7.dtsi                 | 2 +-
>  arch/arm/boot/dts/ecx-2000.dts              | 2 +-
>  arch/arm/boot/dts/exynos3250.dtsi           | 2 +-
>  arch/arm/boot/dts/exynos5.dtsi              | 2 +-
>  arch/arm/boot/dts/exynos5260.dtsi           | 2 +-
>  arch/arm/boot/dts/exynos5410.dtsi           | 2 +-
>  arch/arm/boot/dts/exynos5440.dtsi           | 2 +-
>  arch/arm/boot/dts/omap5.dtsi                | 2 +-
>  arch/arm/boot/dts/r8a73a4.dtsi              | 2 +-
>  arch/arm/boot/dts/r8a7790.dtsi              | 2 +-
>  arch/arm/boot/dts/r8a7791.dtsi              | 2 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi            | 2 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi            | 2 +-
>  arch/arm/boot/dts/tegra114.dtsi             | 2 +-
>  arch/arm/boot/dts/tegra124.dtsi             | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 2 +-
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 2 +-
>  arch/arm64/boot/dts/apm-storm.dtsi          | 2 +-
>  arch/arm64/boot/dts/foundation-v8.dts       | 2 +-
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts      | 2 +-
>  21 files changed, 21 insertions(+), 21 deletions(-)

For the Tegra114 and Tegra124 patches:

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/e2c028e3/attachment-0001.sig>
