From: haiyue.wang@linux.intel.com (Wang, Haiyue)
Date: Fri, 16 Mar 2018 08:47:51 +0800
Subject: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS
 node
In-Reply-To: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
References: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
Message-ID: <9231baaf-e77c-c517-bca2-083070a53342@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel and Andrew,

Have time to review this patch ? Hope for your comments. :-)

BR,
Haiyue

On 2018-03-07 13:04, Haiyue Wang wrote:
> The IPMI KCS device part of the LPC interface and is used for
> communication with the host processor.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 43 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 8eac57c..f443169 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -267,8 +267,40 @@
>   				ranges = <0x0 0x1e789000 0x1000>;
>   
>   				lpc_bmc: lpc-bmc at 0 {
> -					compatible = "aspeed,ast2500-lpc-bmc";
> +					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
>   					reg = <0x0 0x80>;
> +					reg-io-width = <4>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0x0 0x0 0x80>;
> +
> +					kcs1: kcs1 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <1>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
> +					kcs2: kcs2 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <2>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
> +					kcs3: kcs3 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <3>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
>   				};
>   
>   				lpc_host: lpc-host at 80 {
> @@ -294,6 +326,15 @@
>   						status = "disabled";
>   					};
>   
> +					kcs4: kcs4 at 0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0xa0>;
> +						interrupts = <8>;
> +						kcs_chan = <4>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
>   					lhc: lhc at 20 {
>   						compatible = "aspeed,ast2500-lhc";
>   						reg = <0x20 0x24 0x48 0x8>;
