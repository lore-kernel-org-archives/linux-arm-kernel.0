From: lznuaa@gmail.com (Zhi Li)
Date: Fri, 26 Feb 2016 11:31:12 -0600
Subject: [i.MX] various errors in arch/arm/boot/dts/imx*-pinfunc.h files
In-Reply-To: <20160226124413.71cef89a@ipc1.ka-ro>
References: <20160226124413.71cef89a@ipc1.ka-ro>
Message-ID: <CAHrpEqT6+DdBdaVHAfkJOYUFrOV7fNxk4fce+Bn6y9m4wU5gvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:44 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> after finding a bug in the imx6ul-pinconf.h file (missing input_sel
> config for MX6UL_PAD_UART5_RX_DATA__ECSPI2_MISO), I decided
> to write a perl script (see attachment) to check the file for
> consistency and found 44 more errors in the same file.
>
> Running the script over the remaining imx pinconf files revealed the
> following errors:
> arch/arm/boot/dts/imx35-pinfunc.h:
> ----------------------------------
> ERROR: Missing INPUT_SEL address for FUNCTION 'KPP_ROW_3' on PAD 'MX35_PAD_CSI_D15',
>         other pads for this function are:
>         MX35_PAD_FST             0x097c 0x1
>         MX35_PAD_ATA_BUFF_EN     0x097c 0x2
> ERROR: Missing INPUT_SEL address for FUNCTION 'AUDMUX_AUD6_RXC' on PAD 'MX35_PAD_FEC_RDATA1',
>         other pads for this function are:
>         MX35_PAD_ATA_DATA10      0x07b8 0x0
> ERROR: Missing INPUT_SEL address for FUNCTION 'AUDMUX_AUD5_RXC' on PAD 'MX35_PAD_RTS2',
>         other pads for this function are:
>         MX35_PAD_HCKT            0x07a8 0x0
> arch/arm/boot/dts/imx35-pinfunc.h: 952 pads checked: 3 errors found
>
> arch/arm/boot/dts/imx50-pinfunc.h:
> ----------------------------------
> ERROR: Missing INPUT_SEL address for FUNCTION 'UART3_CTS' on PAD 'MX50_PAD_ECSPI1_MOSI',
>         other pads for this function are:
>         MX50_PAD_UART4_TXD       0x07d0 0x0
> ERROR: Duplicate MUX reg addr 0x01f8 for pad 'MX50_PAD_EPDC_GDRL' and 'MX50_PAD_EPDC_GDOE'
> ERROR: Duplicate INPUT_SEL value 0x0 for FUNC 'ELCDIF_DAT_4' on pad 'MX50_PAD_EPDC_SDCE1'
>         pads for this function are:
>         MX50_PAD_DISP_D4         0x070c 0x0
>         MX50_PAD_EPDC_SDCE1      0x070c 0x0
> arch/arm/boot/dts/imx50-pinfunc.h: 905 pads checked: 3 errors found
>
> arch/arm/boot/dts/imx51-pinfunc.h:
> ----------------------------------
> ERROR: Missing INPUT_SEL address for FUNCTION 'DISP1_EXT_CLK' on PAD 'MX51_PAD_DISPB2_SER_RS',
>         other pads for this function are:
>         MX51_PAD_EIM_CS5         0x0904 0x0
> ERROR: Duplicate MUX value 0x2 for FUNC 'DISP1_EXT_CLK' and 'DISP1_PIN16' on PAD 'MX51_PAD_DISPB2_SER_RS'
> arch/arm/boot/dts/imx51-pinfunc.h: 755 pads checked: 1 errors found
>
> arch/arm/boot/dts/imx7d-pinfunc.h:
> ----------------------------------
> ERROR: Missing INPUT_SEL address for FUNCTION 'KPP_COL1' on PAD 'MX7D_PAD_ENET1_RGMII_RXC',
>         other pads for this function are:
>         MX7D_PAD_EPDC_DATA05     0x05f8 0x0
> ERROR: Missing INPUT_SEL address for FUNCTION 'SAI1_RX_BCLK' on PAD 'MX7D_PAD_ENET1_RGMII_TXC',
>         other pads for this function are:
>         MX7D_PAD_SAI1_RX_BCLK    0x069c 0x0
> ERROR: Missing INPUT_SEL address for FUNCTION 'SAI1_RX_SYNC' on PAD 'MX7D_PAD_ENET1_RGMII_TX_CTL',
>         other pads for this function are:
>         MX7D_PAD_SAI1_RX_SYNC    0x06a4 0x0
> ERROR: Duplicate MUX reg addr 0x0014 for pad 'MX7D_PAD_GPIO1_IO08' and 'MX7D_PAD_GPIO1_IO05'
> ERROR: Duplicate MUX reg addr 0x0018 for pad 'MX7D_PAD_GPIO1_IO09' and 'MX7D_PAD_GPIO1_IO06'
> ERROR: Duplicate MUX reg addr 0x001c for pad 'MX7D_PAD_GPIO1_IO10' and 'MX7D_PAD_GPIO1_IO07'
> ERROR: Missing INPUT_SEL address for FUNCTION 'CCM_PMIC_READY' on PAD 'MX7D_PAD_UART1_RX_DATA',
>         other pads for this function are:
>         MX7D_PAD_GPIO1_IO09      0x04f4 0x0
>         MX7D_PAD_GPIO1_IO13      0x04f4 0x1
>         MX7D_PAD_SAI1_MCLK       0x04f4 0x3
> ERROR: Missing INPUT_SEL address for FUNCTION 'ENET1_MDIO' on PAD 'MX7D_PAD_UART1_RX_DATA',
>         other pads for this function are:
>         MX7D_PAD_GPIO1_IO10      0x0568 0x0
>         MX7D_PAD_SD2_CD_B        0x0568 0x2
> ERROR: Missing INPUT_SEL address for FUNCTION 'SAI3_RX_BCLK' on PAD 'MX7D_PAD_UART2_RX_DATA',
>         other pads for this function are:
>         MX7D_PAD_SD1_CMD         0x06c4 0x1
>         MX7D_PAD_SD3_CMD         0x06c4 0x2
> ERROR: Missing INPUT_SEL address for FUNCTION 'ENET2_MDIO' on PAD 'MX7D_PAD_UART2_RX_DATA',
>         other pads for this function are:
>         MX7D_PAD_GPIO1_IO14      0x0574 0x0
>         MX7D_PAD_SD2_CD_B        0x0574 0x2
> ERROR: Missing INPUT_SEL address for FUNCTION 'UART2_DTE_RX' on PAD 'MX7D_PAD_UART2_TX_DATA',
>         other pads for this function are:
>         MX7D_PAD_LCD_ENABLE      0x06fc 0x1
> ERROR: Missing INPUT_SEL address for FUNCTION 'ECSPI1_SCLK' on PAD 'MX7D_PAD_UART3_RTS_B',
>         other pads for this function are:
>         MX7D_PAD_ECSPI1_SCLK     0x0524 0x1
> arch/arm/boot/dts/imx7d-pinfunc.h: 1135 pads checked: 12 errors found
>
>
> I will send a patch for imx6ul and imx51 shortly.
> But I have no resources to correct the bugs in the imx35, imx50 and
> imx7d files.
> The "Duplicate MUX reg addr" message for imx7d are false positives due
> to the deviant nature of the imx7d pinctrl design, but the other
> messages should be relevant.

Thanks. We will check auto generate script and found why this happen.

best regards
Frank Li

>
>
>
> Lothar Wa?mann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
