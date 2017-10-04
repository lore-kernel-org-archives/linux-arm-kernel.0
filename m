From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 14:05:59 +1030
Subject: [PATCH 2/8] ARM: dts: aspeed: Reorder ADC node
In-Reply-To: <20170928075149.8154-3-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-3-joel@jms.id.au>
Message-ID: <1507088159.5452.3.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
> We try to keep the nodes in address order. The ADC node was out of
> place.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?arch/arm/boot/dts/aspeed-g4.dtsi | 16 ++++++++--------
> ?arch/arm/boot/dts/aspeed-g5.dtsi | 16 ++++++++--------
> ?2 files changed, 16 insertions(+), 16 deletions(-)
>?
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 1edd0cee6221..a4579498fc25 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -129,6 +129,14 @@
> ?				};
> ?			};
> ?
> +			adc: adc at 1e6e9000 {
> +				compatible = "aspeed,ast2400-adc";
> +				reg = <0x1e6e9000 0xb0>;
> +				clocks = <&syscon ASPEED_CLK_APB>;

We can't do this yet as the clk driver isn't yet merged, and it breaks from the
"just move the node" description in the commit message.

> +				#io-channel-cells = <1>;
> +				status = "disabled";
> +			};
> +
> ?			sram at 1e720000 {
> ?				compatible = "mmio-sram";
> ?				reg = <0x1e720000 0x8000>;	// 32K
> @@ -227,14 +235,6 @@
> ?				no-loopback-test;
> ?				status = "disabled";
> ?			};
> -
> -			adc: adc at 1e6e9000 {
> -				compatible = "aspeed,ast2400-adc";
> -				reg = <0x1e6e9000 0xb0>;
> -				clocks = <&clk_apb>;
> -				#io-channel-cells = <1>;
> -				status = "disabled";
> -			};
> ?		};
> ?	};
> ?};
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index f56dd67efa50..f6430b313f90 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -173,6 +173,14 @@
> ?				reg-io-width = <4>;
> ?			};
> ?
> +			adc: adc at 1e6e9000 {
> +				compatible = "aspeed,ast2500-adc";
> +				reg = <0x1e6e9000 0xb0>;

Did you intend to change the size cell value here? It now matches the g4, but
there was an explicit comment about the size for some reason in the -hunk
below. It's probably worth an explicit call-out if we're going to change it.?

> +				clocks = <&syscon ASPEED_CLK_APB>;

See the clk comment on the g4 diff.

Cheers,

Andrew

> +				#io-channel-cells = <1>;
> +				status = "disabled";
> +			};
> +
> ?			sram at 1e720000 {
> ?				compatible = "mmio-sram";
> ?				reg = <0x1e720000 0x9000>;	// 36K
> @@ -307,14 +315,6 @@
> ?				no-loopback-test;
> ?				status = "disabled";
> ?			};
> -
> -			adc: adc at 1e6e9000 {
> -				compatible = "aspeed,ast2500-adc";
> -				reg = <0x1e6e9000 0xb0>;
> -				clocks = <&clk_apb>;
> -				#io-channel-cells = <1>;
> -				status = "disabled";
> -			};
> ?		};
> ?	};
> ?};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/68b7ed2f/attachment.sig>
