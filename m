From: joel@jms.id.au (Joel Stanley)
Date: Tue, 24 Jul 2018 13:59:25 +0930
Subject: [PATCH 1/5] arm: dts: aspeed: Add coprocessor interrupt controller
In-Reply-To: <20180724042406.15374-2-benh@kernel.crashing.org>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
 <20180724042406.15374-2-benh@kernel.crashing.org>
Message-ID: <CACPK8Xe53YJ6GmEk6gyN5DNgEHn5V+CGNSKNE-MNw8Osugf2=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2018 at 13:54, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Add the missing node for the CVIC (the coprocessor interrupt
> controller) and add a label to the SRAM node so it can be
> referenced from the board device-tree file.
>
> OpenBMC-Staging-Count: 1

We shouldn't be putting this in upstream patches.

I can drop it when I apply if there is no other review.


> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 8 +++++++-
>  arch/arm/boot/dts/aspeed-g5.dtsi | 9 ++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 75df1573380e..b1a19f99a4c9 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -92,6 +92,12 @@
>                         reg = <0x1e6c0080 0x80>;
>                 };
>
> +               cvic: copro-interrupt-controller at 1e6c2000 {
> +                       compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
> +                       valid-sources = <0x7fffffff>;
> +                       reg = <0x1e6c2000 0x80>;
> +               };
> +
>                 mac0: ethernet at 1e660000 {
>                         compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
>                         reg = <0x1e660000 0x180>;
> @@ -161,7 +167,7 @@
>                                 status = "disabled";
>                         };
>
> -                       sram at 1e720000 {
> +                       sram: sram at 1e720000 {
>                                 compatible = "mmio-sram";
>                                 reg = <0x1e720000 0x8000>;      // 32K
>                         };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 17f2714d18a7..21141ca1bfa4 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -127,6 +127,13 @@
>                         reg = <0x1e6c0080 0x80>;
>                 };
>
> +               cvic: copro-interrupt-controller at 1e6c2000 {
> +                       compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
> +                       valid-sources = <0xffffffff>;
> +                       copro-sw-interrupts = <1>;
> +                       reg = <0x1e6c2000 0x80>;
> +               };
> +
>                 mac0: ethernet at 1e660000 {
>                         compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
>                         reg = <0x1e660000 0x180>;
> @@ -211,7 +218,7 @@
>                                 status = "disabled";
>                         };
>
> -                       sram at 1e720000 {
> +                       sram: sram at 1e720000 {
>                                 compatible = "mmio-sram";
>                                 reg = <0x1e720000 0x9000>;      // 36K
>                         };
> --
> 2.17.1
>
