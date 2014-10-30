From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 30 Oct 2014 14:54:18 +0100
Subject: [PATCH/RFC] ARM: shmobile: lager: Add I2C2 clock frequency to
 device tree
In-Reply-To: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648520-30184-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20141030135417.GD23852@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 02:55:20PM +0900, Simon Horman wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> 
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [simon: rebased]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> 
> If this is useful I wonder if it is should be set in the lager board DTS
> file instead of the r8a7790 SoC DTSI file.

? This IS set in the .dts and not the .dtsi.

400kHz should never be set in a .dtsi. Not all i2c slave devices support
it. 100kHz is the default which all slaves need to support. But since
I've seen cases where the board needs to lower even further because of
board design issues, I'm getting reluctant to set even 100kHz in dtsi
files in general.

> 
> 
>  arch/arm/boot/dts/r8a7790-lager.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 830f2e8..32c7e48 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -426,6 +426,7 @@
>  
>  &iic2	{
>  	status = "ok";
> +	clock-frequency = <400000>;
>  	pinctrl-0 = <&iic2_pins>;
>  	pinctrl-names = "default";
>  
> -- 
> 2.1.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/8e0a2688/attachment.sig>
