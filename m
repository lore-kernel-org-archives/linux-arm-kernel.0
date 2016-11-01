From: olof@lixom.net (Olof Johansson)
Date: Tue, 1 Nov 2016 15:23:52 -0700
Subject: [PATCHv2] ARM: dts: socfpga: add specific compatible strings for
 boards
In-Reply-To: <20161101205652.26384-1-dinguyen@kernel.org>
References: <20161101205652.26384-1-dinguyen@kernel.org>
Message-ID: <20161101222352.GA6328@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 03:56:52PM -0500, Dinh Nguyen wrote:
> Add a more specific board compatible entry for all of the SOCFPGA
> Cyclone 5 based boards.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: remove extra space and add a comma between compatible entries
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 2 +-
>  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> index afea364..5ecd2ef 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> @@ -18,7 +18,7 @@
>  
>  / {
>  	model = "Terasic DE-0(Atlas)";
> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +	compatible = "terasic,de0-atlas", "altr,socfpga-cyclone5", "altr,socfpga";
>  
>  	chosen {
>  		bootargs = "earlyprintk";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
> index 424523b..e5a98e5 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
> @@ -19,7 +19,7 @@
>  
>  / {
>  	model = "Aries/DENX MCV EVK";
> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +	compatible = "denx,mcvevk", "altr,socfpga-cyclone5", "altr,socfpga";
>  
>  	aliases {
>  		ethernet0 = &gmac0;
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index 15e43f4..b0577c1 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -19,7 +19,7 @@
>  
>  / {
>  	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +	compatible = "altr,socdk", "altr,socfpga-cyclone5", "altr,socfpga";

This looks a little too generic, what if there's another dk with another
SoC down the road?

>  	chosen {
>  		bootargs = "earlyprintk";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index 02e22f5..c5623a7 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -19,7 +19,7 @@
>  
>  / {
>  	model = "Terasic SoCkit";
> -	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +	compatible = "terasic,sockit", "altr,socfpga-cyclone5", "altr,socfpga";

Same thing here, this seems a bit on the generic side.



-Olof
