From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:16:19 +0100
Subject: [PATCH v2 10/19] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <20171215062443.23059-11-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-11-joel@jms.id.au>
Message-ID: <c5ef27de-34c1-f5e9-e4ae-e2709b004677@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> LPC snoop hardware on the ASPEED BMC, used for monitoring
> host I/O port activity.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index f6fee40c04c0..b3580f37f507 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -236,6 +236,13 @@
>  						status = "disabled";
>  					};
>  
> +					lpc_snoop: lpc-snoop at 0 {
> +						compatible = "aspeed,ast2500-lpc-snoop";

it should be :

	aspeed,ast2400-lpc-snoop

a part from that :

Reviewed-by: C?dric Le Goater <clg@kaod.org>

> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						status = "disabled";
> +					};
> +
>  					lhc: lhc at 20 {
>  						compatible = "aspeed,ast2500-lhc";
>  						reg = <0x20 0x24 0x48 0x8>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 96a9d2fe3f0d..50766f0629f8 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -287,6 +287,12 @@
>  						status = "disabled";
>  					};
>  
> +					lpc_snoop: lpc-snoop at 0 {
> +						compatible = "aspeed,ast2500-lpc-snoop";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						status = "disabled";
> +					};
>  
>  					lhc: lhc at 20 {
>  						compatible = "aspeed,ast2500-lhc";
> 
