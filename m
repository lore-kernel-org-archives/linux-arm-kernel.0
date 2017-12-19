From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Tue, 19 Dec 2017 18:22:13 +0100
Subject: [PATCH 2/6] ARM: dts: imx6: Add initial support for phyBOARD-Mira
In-Reply-To: <CAOMZO5CSQSpPXTnR69HqHfKZiUpi+eqonqjuEu9mgBECsWG_5g@mail.gmail.com>
References: <1513698588-13325-1-git-send-email-s.riedmueller@phytec.de>
 <1513698588-13325-3-git-send-email-s.riedmueller@phytec.de>
 <CAOMZO5CSQSpPXTnR69HqHfKZiUpi+eqonqjuEu9mgBECsWG_5g@mail.gmail.com>
Message-ID: <1513704133.2106.4.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-19 at 15:10 -0200, Fabio Estevam wrote:
> On Tue, Dec 19, 2017 at 1:49 PM, Stefan Riedmueller
> <s.riedmueller@phytec.de> wrote:
> 
> > +       reg_pcie: regulator-pcie {
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_pcie_reg>;
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "mPCIe_1V5";
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1500000>;
> > +               gpio = <&gpio3 0 GPIO_ACTIVE_HIGH>;
> > +               regulator-always-on;
> 
> Instead of using 'regulator-always-on' here, you could use:
> 
> vpcie-supply = <&reg_pcie>;
> 
> under the &pcie node
> 
> > +       panel {
> > +               compatible = "auo,g104sn02";
> 
> I could not find this compatible in linux-next.

FYI: I've sent this a few days ago:
https://www.spinics.net/lists/devicetree/msg206590.html
