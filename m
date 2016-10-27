From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 27 Oct 2016 09:06:26 +0200
Subject: [PATCHv2] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <1477505112-26079-1-git-send-email-dinguyen@opensource.altera.com>
References: <1477505112-26079-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20161027070626.s3wwiadf2iumxe4u@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 01:05:12PM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Enable the QSPI node and add the flash chip.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v2: Remove partition entries for the SoCKIT
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index 02e22f5..2ce6736 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -175,6 +175,27 @@
>  	status = "okay";
>  };
>  
> +&qspi {
> +	status = "okay";
> +
> +	flash: flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q256a";

Did you test if this works correctly? According to my datasheet (Rev. C)
the HPS qspi is a n25q00. The n25q256a is the other one.

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
