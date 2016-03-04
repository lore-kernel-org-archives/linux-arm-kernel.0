From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 4 Mar 2016 13:33:03 +0100
Subject: [PATCH] ARM: dts: imx25-pinfunc: add MX25_PAD_KPP_ROW3__UART1_RI
In-Reply-To: <1457085652-4748-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457085652-4748-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160304133303.109baa10@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri,  4 Mar 2016 11:00:52 +0100 Uwe Kleine-K?nig wrote:
> Funny side note: When uart1 is used in dte mode (where RI is an input)
> the RIIN bit in uart1's USR2 register reflects the input level of
> MX25_PAD_KPP_ROW3 even if this pad is muxed to a different function.
> The same seems to hold for some other pads, too.
> 
I guess that's not a funny side note, but the expected behaviour when
the SION bit in the MUX control register is set.

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I think the appropriate action for the "funny" side note is that we must
> introduce dt-properties like
> 
> 	fsl,mask-ri;
> 
> or something similar (maybe positive logic?) that prevents an uart1 RI irq
> whenever uart3.CTS toggles.
> 
> Best regards
> Uwe
> 
>  arch/arm/boot/dts/imx25-pinfunc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
> index 848ffa785b63..3c8c5e1bea9e 100644
> --- a/arch/arm/boot/dts/imx25-pinfunc.h
> +++ b/arch/arm/boot/dts/imx25-pinfunc.h
> @@ -453,6 +453,7 @@
>  
>  #define MX25_PAD_KPP_ROW3__KPP_ROW3		0x1b4 0x3ac 0x000 0x10 0x000
>  #define MX25_PAD_KPP_ROW3__CSI_D1		0x1b4 0x3ac 0x48c 0x13 0x002
> +#define MX25_PAD_KPP_ROW3__UART1_RI		0x1b4 0x3ac 0x000 0x14 0x000
>  #define MX25_PAD_KPP_ROW3__GPIO_3_0		0x1b4 0x3ac 0x000 0x15 0x000
                                                                  ^^^^
Do you still have the side effect, with SION (0x10) cleared?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
