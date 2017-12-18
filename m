From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 18 Dec 2017 10:40:18 +0100
Subject: [PATCH 04/25] arm: exynos/s3c: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124630.30082-1-malat@debian.org>
References: <20171215124630.30082-1-malat@debian.org>
Message-ID: <CAJKOXPdkYLisej5965rh2SbOjbFms-RK2VnXt=L==MW_JcA+OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 1:46 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
>
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>
> and
>
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>
> Converted using the following command:
>
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
>
> For simplicity, two sed expressions were used to solve each warnings separately.
>
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before the
> the opening curly brace:
>
> https://elinux.org/Device_Tree_Linux#Linux_conventions
>
> This will solve as a side effect warning:
>
> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
>
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Ack was for different patchset, touching only three files...

> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi             | 34 ++++++------
>  arch/arm/boot/dts/exynos4.dtsi                | 56 +++++++++----------
>  arch/arm/boot/dts/exynos4210.dtsi             |  8 +--
>  arch/arm/boot/dts/exynos4412-pinctrl.dtsi     |  2 +-
>  arch/arm/boot/dts/exynos4412.dtsi             | 22 ++++----
>  arch/arm/boot/dts/exynos5.dtsi                | 22 ++++----
>  arch/arm/boot/dts/exynos5250.dtsi             | 64 +++++++++++-----------
>  arch/arm/boot/dts/exynos5260.dtsi             | 26 ++++-----
>  arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++--------------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
>  arch/arm/boot/dts/exynos5440.dtsi             | 14 ++---
>  arch/arm/boot/dts/s3c2416.dtsi                |  8 +--
>  12 files changed, 168 insertions(+), 168 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 2bd3872221a1..8d47571b3984 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -164,31 +164,31 @@
>                         syscon = <&pmu_system_controller>;
>                 };
>
> -               pd_cam: cam-power-domain at 10023C00 {
> +               pd_cam: cam-power-domain at 10023c00 {

This is not related to this patch and it was not present in the
version I acked. I also already fixed this here:
https://patchwork.kernel.org/patch/10113323/

There is no changelog explaining the difference in patches. Original
patch was okay, why changing it?

Best regards,
Krzysztof
