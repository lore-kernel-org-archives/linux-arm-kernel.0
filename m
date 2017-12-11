From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Dec 2017 08:16:35 +0100
Subject: [PATCH 5/5] arm: dts: sun8i: a83t: a711: Add touchscreen node
In-Reply-To: <20171208215419.30396-6-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-6-mylene.josserand@free-electrons.com>
Message-ID: <20171211071635.4ntdksmjino4uh2i@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 08, 2017 at 10:54:19PM +0100, Myl?ne Josserand wrote:
> Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
> It is connected via I2C0 so add his node in i2c0's node.
> 
> The reset line is PD5, the interrupt line is PL7 and the power
> supply is the ldo_io0 regulator.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index 84cca1a48cea..738359917a34 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -110,6 +110,17 @@
>  	pinctrl-0 = <&i2c0_pins>;
>  	clock-frequency = <400000>;
>  	status = "okay";
> +
> +	polytouch: edt-ft5x06 at 38 {

You're not using that label anywhere, so you can drop it, and the node
name must be the class of the device.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171211/fc3bc50e/attachment-0001.sig>
