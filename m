From: Fabio.Estevam@freescale.com (Fabio.Estevam at freescale.com)
Date: Tue, 5 Aug 2014 16:09:01 +0000
Subject: i.MX25 esdhc2 incomplete cmd0 transmission
In-Reply-To: <20140729124808.GF13842@pengutronix.de>
References: <20140728080633.GA13842@pengutronix.de>,
 <20140729124808.GF13842@pengutronix.de>
Message-ID: <1407254932760.78584@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Sorry for top-posting here]

Are you sure 0x00000000 are the correct values for the IOMUX?

Or do you mean 0x80000000, which would let the same IOMUX as configured by the bootloader?

Are you able to correctly access port esdhc2 from the bootloader?

________________________________________
From: Markus Pargmann <mpa@pengutronix.de>
Sent: Tuesday, July 29, 2014 9:48 AM
To: Guo Shawn-R65073
Cc: Estevam Fabio-R49496; linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de
Subject: i.MX25 esdhc2 incomplete cmd0 transmission

Hi,

This mail did not reach the mailinglist, so here is the same mail
without the images attached.

On Mon, Jul 28, 2014 at 10:06:33AM +0200, Markus Pargmann wrote:
> Hi,
>
> I am currently having a Board with an i.MX25 which has an SD-Card slot
> wired to the CSI pins (ESDHC2). I can see the correct clock and the beginning of
> the cmd0 on the CMD wire (01 00000). But the arguments and CRC that
> should follow the comand are missing. The card doesn't respond to this.
> The same behavior is observable on the karo tx25 module with an
> oscilloscope on ESDHC2.
>
> The tx25 works correctly with the same software and the ESDHC1. I can
> see the complete cmd0 command even without any SD card plugged in, as
> expected. I attached some oscilloscope pictures of these two cases to
> this mail.
>
> This is the pincontrol setup I am using for esdhc2 on karo tx25:
>
> #define MX25_PAD_CSI_HSYNC__SDHC2_DAT2                0x148 0x340 0x4ec 0x02 0x001
> #define MX25_PAD_CSI_MCLK__SDHC2_DAT0         0x140 0x338 0x4e4 0x02 0x001
> #define MX25_PAD_CSI_PIXCLK__SDHC2_DAT3               0x14c 0x344 0x4f0 0x02 0x001
> #define MX25_PAD_CSI_VSYNC__SDHC2_DAT1                0x144 0x33c 0x4e8 0x02 0x001
> #define MX25_PAD_CSI_D6__SDHC2_CMD            0x130 0x328 0x4e0 0x02 0x001
> #define MX25_PAD_CSI_D7__SDHC2_DAT_CLK                0x134 0x32C 0x4dc 0x02 0x001
>       esdhc {
>               pinctrl_esdhc2: esdhc2 {
>                       fsl,pins = <
>                               MX25_PAD_CSI_HSYNC__SDHC2_DAT2          0x00000000
>                               MX25_PAD_CSI_MCLK__SDHC2_DAT0           0x00000000
>                               MX25_PAD_CSI_PIXCLK__SDHC2_DAT3         0x00000000
>                               MX25_PAD_CSI_VSYNC__SDHC2_DAT1          0x00000000
>                               MX25_PAD_CSI_D6__SDHC2_CMD              0x00000000
>                               MX25_PAD_CSI_D7__SDHC2_DAT_CLK          0x00000000
>                       >;
>               };
>       };
>
> Any ideas what may be wrong/missing?

Here are the images uploaded to a ftp server:

karo tx25 esdhc1 initial communication without SD card inserted:
ftp://ftp.pengutronix.de/pub/20140729_imx25-esdhc2-scope/karo_2.png
ftp://ftp.pengutronix.de/pub/20140729_imx25-esdhc2-scope/karo.png

and the same with karo tx25 esdhc2 and the above pincontrol setup:
ftp://ftp.pengutronix.de/pub/20140729_imx25-esdhc2-scope/karo_esdhc2.png
ftp://ftp.pengutronix.de/pub/20140729_imx25-esdhc2-scope/karo_esdhc2_2.png

Thanks,

Markus

--
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
