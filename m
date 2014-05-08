From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 8 May 2014 09:18:35 +0200
Subject: Adding esdhc4 eMMC support on mx6sabresd
In-Reply-To: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
References: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
Message-ID: <20140508091835.78daafbe@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam wrote:
> Hi Dong,
> 
> I have tested the following patch to add support for the emmc port on
> mx6qsabresd:
> 
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -444,6 +444,21 @@
>                                 MX6QDL_PAD_SD3_DAT7__SD3_DATA7          0x17059
>                         >;
>                 };
> +
> +               pinctrl_usdhc4: usdhc4grp {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_SD4_CMD__SD4_CMD             0x17059
> +                               MX6QDL_PAD_SD4_CLK__SD4_CLK             0x10059
> +                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0          0x17059
> +                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1          0x17059
> +                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2          0x17059
> +                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3          0x17059
> +                               MX6QDL_PAD_SD4_DAT4__SD4_DATA4          0x17059
> +                               MX6QDL_PAD_SD4_DAT5__SD4_DATA5          0x17059
> +                               MX6QDL_PAD_SD4_DAT6__SD4_DATA6          0x17059
> +                               MX6QDL_PAD_SD4_DAT7__SD4_DATA7          0x17059
[...]
> 
> Is there any extra patch I need to apply? I am running linux-next 20140506.
> 
I'm using the pad settings 0x070b1 for our i.MX6 module with eMMC.
At least you should probably drop the HYS setting (0x10000), since
according to my experience the SD interface works much better with
hysteresis disabled.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
