From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 1 Nov 2018 15:49:24 +0000
Subject: [PATCH V3 09/10] dts: fsl: add imx7ulp evk support
In-Reply-To: <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-10-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5AZejEAHeB0hQ9T5U2ZJ7MXK=BYm8jY+yyZjbDHo4utGA@mail.gmail.com>
Message-ID: <VI1PR04MB422242A027713CC447446D6780CE0@VI1PR04MB4222.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, November 1, 2018 6:28 PM
[...]
> Hi Dong,
> 
> On Wed, Oct 31, 2018 at 11:46 AM A.s. Dong <aisheng.dong@nxp.com>
> wrote:
> 
> > +       reg_vsd_3v3: regulator-vsd-3v3 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "VSD_3V3";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_usdhc0_rst>;
> > +               gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> 
> You model this as a regulator...
> 
> > +&usdhc0 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_usdhc0>;
> > +       cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
> > +       vmmc-supply = <&reg_vsd_3v3>;
> 
> but as this pins controls the reset of the SD port it seems that using
> mmc-pwrseq would be more appropriate.
> 
> This way you could pass 'reset-gpios' inside the pwrseq node, which would
> describe the hardware more accurately.

This seems a bit confusing to me.
That GPIO is used to control the SD card power on/off. So it's naturally a
GPIO regulator. Looking at exist IMX dts, you will find all similar board doing
like this. Pwrseq seems more like to be used for WiFi/eMMC card.
Am I missed something?

Regards
Dong Aisheg
