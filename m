From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 24 Nov 2017 15:41:13 +0100
Subject: [PATCH v2 4/6] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM
 support
In-Reply-To: <CAOMZO5CuxBsMv1zabi3JtYyX0wNpv1rZZmZG28BBfo9a155siQ@mail.gmail.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
 <1511348560-28505-5-git-send-email-narmstrong@baylibre.com>
 <CAOMZO5CuxBsMv1zabi3JtYyX0wNpv1rZZmZG28BBfo9a155siQ@mail.gmail.com>
Message-ID: <bbbd71e2-eb31-4d43-7dfc-0ef817c5e13e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 24/11/2017 15:31, Fabio Estevam wrote:
> On Wed, Nov 22, 2017 at 9:02 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> +       reg_wl18xx_vmmc: regulator-wl18xx {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vwl1807";
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <1800000>;
>> +               gpio = <&gpio7 8 GPIO_ACTIVE_HIGH>;
> 
> Is this really GPIO_ACTIVE_HIGH?
> 
> If so, then a 'enable-active-high' property would be needed.

Indeed, it's quite redundant with the GPIO_ACTIVE_* flag, but whatever.

> 
>> +&hdmi {
> 
> No ddc-i2c-bus property?

It's in the board dts.

> 
>> +       pinctrl_pmic: pmicgrp {
>> +               fsl,pins = <
>> +                       /* PMIC INT */
>> +                       MX6QDL_PAD_GPIO_17__GPIO7_IO12          0x80000000
> 
> No 0x80000000 please. Use the real IOMUX value here instead.

Ok

> 
>> +&pcie {
>> +       fsl,tx-swing-full = <103>;
>> +       fsl,tx-swing-low = <103>;
>> +       status = "disabled";
> 
> No 'reset-gpio' property?
> 

It will be in the board dts.

Neil
