From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 27 Oct 2012 17:08:36 +0200
Subject: [PATCH 2/4] mfd: ab8500: add devicetree support for btemp
In-Reply-To: <1351146654-9110-3-git-send-email-rajanikanth.hv@stericsson.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-3-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <508BF8F4.1060006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> This patch adds device tree support for
> battery-temperature-monitor driver
> 
> Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
> ---
>  Documentation/devicetree/bindings/mfd/ab8500.txt   |    6 ++
>  .../bindings/power_supply/ab8500/btemp.txt         |   16 +++++
>  arch/arm/boot/dts/dbx5x0.dtsi                      |    5 ++
>  drivers/mfd/ab8500-core.c                          |    5 ++
>  drivers/power/Kconfig                              |    6 --
>  drivers/power/ab8500_bmdata.c                      |    4 +-
>  drivers/power/ab8500_btemp.c                       |   66 ++++++++++++--------
>  7 files changed, 73 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index 6ca8d81..179c802 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -30,6 +30,12 @@ ab8500-fg                : 			: vddadc       : Fuel Gauge
>  			 : LOW_BAT_F		:	       : LOW threshold battery voltage
>  			 : CC_INT_CALIB		:	       : Coulomb Counter Internal Calibration
>  			 : CCEOC		:	       : Coulomb Counter End of Conversion
> +ab8500-btemp		 :			: vtvout       : Battery Temperature
> +			 : BAT_CTRL_INDB        :              : Battery Removal Indicator
> +			 : BTEMP_LOW            :              : Btemp < BtempLow, if battery temperature is lower than -10?C
> +			 : BTEMP_HIGH           :              : BtempLow < Btemp < BtempMedium,if battery temperature is between -10 and 0?C
> +			 : BTEMP_LOW_MEDIUM     :              : BtempMedium < Btemp < BtempHigh,if battery temperature is between 0?C and?MaxTemp
> +			 : BTEMP_MEDIUM_HIGH    :	       : Btemp > BtempHigh, if battery temperature is higher than ?MaxTemp?

BTEMP_HIGH, BTEMP_LOW_MEDIUM and BTEMP_MEDIUM_HIGH are in the wrong
order and don't correspond to their description.

--
Francesco
