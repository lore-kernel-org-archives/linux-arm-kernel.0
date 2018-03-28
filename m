From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 28 Mar 2018 08:47:22 +0200
Subject: [PATCH] ARM: dts: imx6ull: add UART5 input select register
 definition
In-Reply-To: <1522189496-27837-1-git-send-email-gerg@linux-m68k.org>
References: <1522189496-27837-1-git-send-email-gerg@linux-m68k.org>
Message-ID: <1be3e0b1-6284-04b0-831a-98e79b57c0a7@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am 28.03.2018 um 00:24 schrieb Greg Ungerer:
> The iMX6ULL UART5_RX_DATA_SELECT_INPUT DAISY Register has some different
> bit definitions to that same register in the iMX6UL.
>
> The bits for the iMX6UL:
>
> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
> 100 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT
> 101 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT
>
> But for the iMX6ULL:
>
> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
> 100 UART1_TX_DATA_ALT9 ? Selecting Pad: UART1_TX_DATA for Mode: ALT9
> 101 UART1_RX_DATA_ALT9 ? Selecting Pad: UART1_RX_DATA for Mode: ALT9
> 110 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT0
> 111 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT0
>
> Specifically for a board I am working on with the serial console on UART5
> I need to be able to enable UART5_RX_DATA_ALT0 mode. There is no definition
> for the iMX6ULL version of that in imx6ul-pinfunc.h or imx6ull-pinfunc.h.
>
> Create a new definition specific to the iMX6ULL so that is settable.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
> index 1182023..19100b5 100644
> --- a/arch/arm/boot/dts/imx6ull-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
> @@ -14,6 +14,7 @@
>   * The pin function ID is a tuple of
>   * <mux_reg conf_reg input_reg mux_mode input_val>
>   */
> +#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7

since you mentioned the differences above, could you please add them all?

Thanks
Stefan

>  #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
