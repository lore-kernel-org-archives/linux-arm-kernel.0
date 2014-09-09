From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 09 Sep 2014 13:52:54 +0200
Subject: [PATCH v2 1/4] phy: phy-stih407-usb: Add usb picoPHY driver found
 on stih407 SoC family
In-Reply-To: <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
 <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <1706244.K6iQdujHby@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, September 09, 2014 10:00:15 AM Peter Griffin wrote:
> This is the generic phy driver for the picoPHY ports used by the
> USB2 and USB3 Host controllers when controlling usb2/1.1 devices. It
> is found on STiH407 SoC family from STMicroelectronics.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/phy/Kconfig           |   8 ++
>  drivers/phy/Makefile          |   2 +
>  drivers/phy/phy-stih407-usb.c | 185 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 drivers/phy/phy-stih407-usb.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 0dd7427..58018f7 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -230,4 +230,12 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  
> +config PHY_STIH407_USB
> +	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
> +	depends on ARCH_STI
> +	depends on GENERIC_PHY

I believe that this should use

	select GENERIC_PHY

instead (just like all other PHY drivers except PHY_MIPHY365X which
also should be fixed to use select).

> +	help
> +	  Enable this support to enable the picoPHY device used by USB2
> +	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
> +

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
