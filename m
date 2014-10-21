From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 21 Oct 2014 19:10:33 +0200
Subject: [PATCHv3 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <1413908111-28165-2-git-send-email-dinguyen@opensource.altera.com>
References: <1413908111-28165-1-git-send-email-dinguyen@opensource.altera.com>
 <1413908111-28165-2-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20141021171033.GK10262@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Oct 21, 2014 at 11:15:10AM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Without this patch, the booting the SOCFPGA platform would hang at the
> SDMMC driver loading. The issue, debugged by Doug Anderson, turned out
> to be that the GPIO bank used by the SD card-detect was not set to
> status="okay".
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v3: Correctly degugged the issue to be a gpio node not having status="okay"
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index d7296a5..03a3745 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -37,6 +37,12 @@
>  		 */
>  		ethernet0 = &gmac1;
>  	};
> +
> +	soc {
> +		gpio at ff709000 {
> +			status = "okay";
> +		};
> +	};
>  };
>  

Looks weird. Don't you need to enable the GPIO bank instead:

	&gpio1 {
		status = "okay";
	}

???

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
