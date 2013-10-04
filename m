From: bcousson@baylibre.com (Benoit Cousson)
Date: Fri, 04 Oct 2013 15:01:44 +0200
Subject: [PATCH 1/2] ARM: dts: am335x-bone-common: correct mux mode for
 cmd line
In-Reply-To: <1380281710-12728-1-git-send-email-balajitk@ti.com>
References: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Message-ID: <524EBC38.60306@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Balaji,

On 27/09/2013 13:35, Balaji T K wrote:
> pinmux_emmc_pins: mux mode for cmd line should be MODE2
> to detect eMMC on beagle bone black and beagle bone white + eMMC cape.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Tested-by: Felipe Balbi <balbi@ti.com>
> ---
> based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts
>
>   arch/arm/boot/dts/am335x-bone-common.dtsi |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index ff5c3ca..51f6a99 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -153,7 +153,7 @@
>   	emmc_pins: pinmux_emmc_pins {
>   		pinctrl-single,pins = <
>   			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
> -			0x84 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_csn2.mmc1_cmd */
> +			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
>   			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
>   			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
>   			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
>

Thanks, I'll apply it for 3.13.

Regards,
Benoit
