From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 14 Sep 2013 13:50:11 +0200
Subject: [PATCH 2/4] Add cpuconfig nodes in dts for smp configure.
In-Reply-To: <1378968687-8200-3-git-send-email-cinifr@gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-3-git-send-email-cinifr@gmail.com>
Message-ID: <20130914115011.GA2746@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On Thu, Sep 12, 2013 at 02:51:25PM +0800, Fan Rong wrote:
> Signed-off-by: Fan Rong <cinifr@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 999ff45..bfedcb2 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -20,13 +20,13 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu0: cpu at 0  {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0>;
>  		};
>  
> -		cpu at 1 {
> +		cpu1: cpu at 1 {

Both these changes don't seem really needed, are they?
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <1>;
> @@ -167,6 +167,11 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		cc: cpuconfig at 01c25c00 {
> +			compatible = "allwinner,sun7i-cc";

Please use the sun7i-a20 prefix, and I'd prefer cpu-config instead of
"cc".

Thanks for working on this!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130914/4cf66fd8/attachment.sig>
