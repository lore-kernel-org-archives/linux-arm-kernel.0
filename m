From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 5 Nov 2015 10:15:41 +0800
Subject: [PATCH V2 2/3] ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0
 bus
In-Reply-To: <1446675264-5514-2-git-send-email-marex@denx.de>
References: <1446675264-5514-1-git-send-email-marex@denx.de>
 <1446675264-5514-2-git-send-email-marex@denx.de>
Message-ID: <563ABBCD.8090802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marek

On 11/5/2015 6:14 AM, Marek Vasut wrote:
> Add pinmux for the 4 remaining signals used in 8-bit MMC 0
> bus configuration.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Josh Wu <josh.wu@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/boot/dts/sama5d4.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> V2: Repair the incorrect comments for the pinmux, original version
>      of the commment contained wrong MCI0_DAx references.
>
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 48ca530..d086a7d 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1651,6 +1651,14 @@
>   							 AT91_PIOC 9 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA3, conflict with NAND_D4 */
>   							>;
>   					};
> +					pinctrl_mmc0_dat4_7: mmc0_dat4_7 {
> +						atmel,pins =
> +							<AT91_PIOC 10 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA4, conflict with NAND_D5 */
> +							 AT91_PIOC 11 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA5, conflict with NAND_D6 */
> +							 AT91_PIOC 12 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA6, conflict with NAND_D7 */
> +							 AT91_PIOC 13 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DA7, conflict with NAND_D8 */

PC13 is conflicted with NRD/NANDOE, not D8 (PB18).
with this comment fix, you can add:
Reviewed-by: Josh Wu <josh.wu@atmel.com>

Best Regards,
Josh Wu
> +							>;
> +					};
>   				};
>   
>   				mmc1 {
