From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 15:03:57 -0600
Subject: [RfC v1 3/5] dt-bindings: arm: amlogic: Add support for the
 Oranth Tanix TX3 Mini
In-Reply-To: <20180624182814.31691-4-martin.blumenstingl@googlemail.com>
References: <20180624182814.31691-1-martin.blumenstingl@googlemail.com>
 <20180624182814.31691-4-martin.blumenstingl@googlemail.com>
Message-ID: <20180625210357.GA6694@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2018 at 08:28:12PM +0200, Martin Blumenstingl wrote:
> The Tanix TX3 Mini is a TV box based on the Amlogic S905W chipset. It
> comes with:
> - 1 GiB or 2 GiB of DDR3 memory depending on the model
> - 8 GB or 16 GB eMMC flash depending on the model
> - 802.11 b/g/n wifi (Silicon Valley Microelectronics SSV6051, does not
>   support Bluetooth, not supported by any mailine driver)
> - an LED 7 segment display with an FD628 controller (not supported by
>   any mainline driver)
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
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
