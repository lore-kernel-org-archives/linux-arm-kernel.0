From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Apr 2017 08:10:45 +0200
Subject: [PATCH] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Message-ID: <20170410061045.2jjk5aw75s6am7xv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 10:46:37AM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>  Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
>  arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
>  arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  8 +--

For sunxi,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/d0bd45d1/attachment.sig>
