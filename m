From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 21:45:39 +1030
Subject: [PATCH 2/2] ARM: dts: aspeed: Enable watchdog two
In-Reply-To: <20171004091635.12499-3-joel@jms.id.au>
References: <20171004091635.12499-1-joel@jms.id.au>
 <20171004091635.12499-3-joel@jms.id.au>
Message-ID: <1507115739.5452.33.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 19:46 +1030, Joel Stanley wrote:
> The second watchdog is left running by u-boot in the common
> configurations of the firmware shipped on ASPEED boards. Ensure a driver
> is loaded so the system can succcessfully boot.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> ?arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
> ?arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
> ?2 files changed, 2 deletions(-)
>?
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 5be2e6a39917..9bf84d2ba038 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -212,7 +212,6 @@
> ?			wdt2: watchdog at 1e785020 {
> ?				compatible = "aspeed,ast2400-wdt";
> ?				reg = <0x1e785020 0x1c>;
> -				status = "disabled";
> ?			};
> ?
> ?			vuart: serial at 1e787000 {
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 71e1264b81aa..ca023e9ab0b8 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -256,7 +256,6 @@
> ?			wdt2: watchdog at 1e785020 {
> ?				compatible = "aspeed,ast2500-wdt";
> ?				reg = <0x1e785020 0x20>;
> -				status = "disabled";
> ?			};
> ?
> ?			wdt3: watchdog at 1e785040 {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/e9d5f527/attachment.sig>
