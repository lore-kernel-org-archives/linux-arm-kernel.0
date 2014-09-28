From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Sun, 28 Sep 2014 05:20:16 +0000
Subject: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for imx6sx-sdb
 board
In-Reply-To: <20140928034213.GD12999@dragon>
References: <1411524680-12863-1-git-send-email-b38611@freescale.com>
 <1411524680-12863-4-git-send-email-b38611@freescale.com>
 <20140928032852.GC12999@dragon>
 <49aafc1f34a34c13ac7af2cf4b04fd6d@BY2PR03MB377.namprd03.prod.outlook.com>
 <20140928034213.GD12999@dragon>
Message-ID: <7e14fd7a305d44df90bcae3b16b56d60@BY2PR03MB377.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Shawn-R65073 Sent: Sunday, September 28, 2014 11:42 AM + 0800
>To: Duan Fugang-B38611
>Cc: linux-arm-kernel at lists.infradead.org; b20596 at solarflare.com;
>shawn.guo at linaro.org; kernel at pengutronix.de
>Subject: Re: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for imx6sx-
>sdb board
>
>On Sun, Sep 28, 2014 at 11:34:39AM +0800, Duan Fugang-B38611 wrote:
>> From: Guo Shawn-R65073 Sent: Sunday, September 28, 2014 11:29 AM +
>> 0800
>> >To: Duan Fugang-B38611
>> >Cc: linux-arm-kernel at lists.infradead.org; b20596 at solarflare.com;
>> >shawn.guo at linaro.org; kernel at pengutronix.de
>> >Subject: Re: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for
>> >imx6sx- sdb board
>> >
>> >On Wed, Sep 24, 2014 at 10:11:20AM +0800, Fugang Duan wrote:
>> >> Add enet2 support for imx6sx-sdb board, and add the "fsl,imx6q-fec"
>> >> compatible for fec2 node to be compatible with the old version.
>> >>
>> >> Signed-off-by: Fugang Duan <B38611@freescale.com>
>> >> ---
>> >>  arch/arm/boot/dts/imx6sx-sdb.dts |   28 ++++++++++++++++++++++++++++
>> >>  arch/arm/boot/dts/imx6sx.dtsi    |    2 +-
>> >>  2 files changed, 29 insertions(+), 1 deletions(-)
>> >>
>> >> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts
>> >> b/arch/arm/boot/dts/imx6sx-sdb.dts
>> >> index 82d6b34..06e0977 100644
>> >> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
>> >> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
>> >> @@ -133,6 +133,14 @@
>> >>  &fec1 {
>> >>  	pinctrl-names = "default";
>> >>  	pinctrl-0 = <&pinctrl_enet1>;
>> >> +	pinctrl-assert-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>, <&gpio2 6
>> >> +GPIO_ACTIVE_LOW>;
>> >
>> >I do not think this property is supported by upstream kernel.
>> The upstream kernel how to handle it ?
>
>What are the purpose of these two GPIOs?

MX6SX_PAD_ENET2_COL__GPIO2_IO_6: it is a switch which enable ENET_3V3 and 25Mhz clock for phy.
MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16: it is a switch which enable PERI_3V3 that supply power for some modules including enet MAC and phy.

Regards,
Andy
