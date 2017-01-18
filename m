From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jan 2017 16:09:45 +0200
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20170118140945.cdna46dllbccwk43@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 10:53:31AM +0000, Marc Zyngier wrote:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
> 
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
> 
> In the couple of cases were I knew for sure what implementation
> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the
> TRM for all the other SoCs, I've let them alone.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/alpine.dtsi        | 2 +-
>  arch/arm/boot/dts/axm55xx.dtsi       | 2 +-
>  arch/arm/boot/dts/dra7.dtsi          | 2 +-
>  arch/arm/boot/dts/ecx-2000.dts       | 2 +-
>  arch/arm/boot/dts/exynos3250.dtsi    | 2 +-
>  arch/arm/boot/dts/exynos5.dtsi       | 2 +-
>  arch/arm/boot/dts/exynos5260.dtsi    | 2 +-
>  arch/arm/boot/dts/exynos5440.dtsi    | 2 +-

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>  arch/arm/boot/dts/imx6ul.dtsi        | 4 ++--
>  arch/arm/boot/dts/keystone-k2g.dtsi  | 2 +-
>  arch/arm/boot/dts/keystone.dtsi      | 2 +-
>  arch/arm/boot/dts/ls1021a.dtsi       | 4 ++--
>  arch/arm/boot/dts/mt2701.dtsi        | 2 +-
>  arch/arm/boot/dts/mt6580.dtsi        | 2 +-
>  arch/arm/boot/dts/mt6589.dtsi        | 2 +-
>  arch/arm/boot/dts/mt7623.dtsi        | 2 +-
>  arch/arm/boot/dts/mt8127.dtsi        | 2 +-
>  arch/arm/boot/dts/mt8135.dtsi        | 2 +-
>  arch/arm/boot/dts/omap5.dtsi         | 2 +-
>  arch/arm/boot/dts/r8a73a4.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7743.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7745.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7790.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7791.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7792.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7793.dtsi       | 2 +-
>  arch/arm/boot/dts/r8a7794.dtsi       | 2 +-
>  arch/arm/boot/dts/rk1108.dtsi        | 2 +-
>  arch/arm/boot/dts/rk3036.dtsi        | 2 +-
>  arch/arm/boot/dts/rk322x.dtsi        | 2 +-
>  arch/arm/boot/dts/rk3288.dtsi        | 2 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi     | 2 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi     | 4 ++--
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi    | 2 +-
>  arch/arm/boot/dts/sun8i-h3.dtsi      | 2 +-
>  arch/arm/boot/dts/sun9i-a80.dtsi     | 2 +-
>  37 files changed, 40 insertions(+), 40 deletions(-)
> 
