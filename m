From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Jul 2018 10:23:05 +0200
Subject: [PATCH v2 3/5] dt-bindings: arm: amlogic: Add support for the
 Oranth Tanix TX3 Mini
In-Reply-To: <20180714193725.17837-4-martin.blumenstingl@googlemail.com>
References: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
 <20180714193725.17837-4-martin.blumenstingl@googlemail.com>
Message-ID: <3c199d65-17d7-480f-1306-a578a7de3d5d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 14/07/2018 21:37, Martin Blumenstingl wrote:
> The Tanix TX3 Mini is a TV box based on the Amlogic S905W chipset. It
> comes with:
> - 1 GiB or 2 GiB of DDR3 memory depending on the model
> - 8 GB or 16 GB eMMC flash depending on the model
> - 802.11 b/g/n wifi (Silicon Valley Microelectronics SSV6051, does not
>   support Bluetooth, not supported by any mailine driver)
> - an LED 7 segment display with an FD628 controller (not supported by
>   any mainline driver)

Because all the 7segments drivers were rejected since forever !
Some google guys tried once to push a sort of framework, but they lacked
multiple drivers using their framework...

> - HDMI and AV (CVBS) output
> - 2x USB (utilizing both USB ports provided by the SoC)
> - micro SD card slot
> 
> The board seems to be very similar to the P23x and Q20x reference
> boards:
> - eMMC reset routed to BOOT_9
> - the SDIO wifi chip's reset line is routed to GPIOX_6 and the reference
>   clock is 32.768KHz on PWM_E
> - SD card detection is routed to CARD_6
> - vqmmc of all MMC controllers is hard-wired to 1.8V (VDDIO_BOOT)
> - uart_AO can be accessed after opening the case and soldering RX, TX
>   and GND lines onto the exposed solder points (marked with RX, TX and
>   GND)
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 8178da8742c3..b5c2b5c35766 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -90,6 +90,7 @@ Board compatible values (alphabetically, grouped by SoC):
>    - "amlogic,p241" (Meson gxl s805x)
>  
>    - "amlogic,p281" (Meson gxl s905w)
> +  - "oranth,tx3-mini" (Meson gxl s905w)
>  
>    - "amlogic,q200" (Meson gxm s912)
>    - "amlogic,q201" (Meson gxm s912)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
