From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 06 Jul 2016 17:06:05 -0700
Subject: [PATCH] clk: gxbb: expose CLKID_MMC_PCLK
In-Reply-To: <20160706230749.9620-1-khilman@baylibre.com>
References: <20160706230749.9620-1-khilman@baylibre.com>
Message-ID: <146784996534.73491.14217049599437131929@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Quoting Kevin Hilman (2016-07-06 16:07:49)
> The MMC_PCLK is needed for the SD/eMMC driver.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  include/dt-bindings/clock/gxbb-clkc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index f889d80246cb..5eb69ec74f6b 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -8,5 +8,6 @@
>  #define CLKID_CPUCLK           1
>  #define CLKID_CLK81            12
>  #define CLKID_ETH              36
> +#define CLKID_MMC_PCLK         66

I think you're missing removal of the duplicate macro as well:



diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index a2adf3448b59..f0fab2286c18 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -234,7 +234,7 @@
 #define CLKID_HDMI_PCLK		  63
 #define CLKID_USB1_DDR_BRIDGE	  64
 #define CLKID_USB0_DDR_BRIDGE	  65
-#define CLKID_MMC_PCLK		  66
+/* CLKID_MMC_PCLK */
 #define CLKID_DVIN		  67
 #define CLKID_UART2		  68
 #define CLKID_SANA		  69



Regards,
Mike
