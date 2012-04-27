From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Apr 2012 08:31:09 +0200
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120427034825.GA826@shlinux2.ap.freescale.net>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
 <20120426144446.GN9142@game.jcrosoft.org>
 <20120427034825.GA826@shlinux2.ap.freescale.net>
Message-ID: <20120427063109.GR9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +   this group of pins in this pin configuration node are working on.
> > > +3. The driver can use the function node's name and pin configuration node's
> > > +   name describe the pin function and group hierarchy.
> > > +   For example, Linux IMX pinctrl driver takes the function node's name
> > > +   as the function name and pin configuration node's name as group name to
> > > +   create the map table.
> > > +4. Each pin configuration node should have a phandle, devices can set pins
> > > +   configurations by referring to the phandle of that pin configuration node.
> > > +
> > > +Examples:
> > > +usdhc at 0219c000 { /* uSDHC4 */
> > > +	fsl,card-wired;
> > > +	vmmc-supply = <&reg_3p3v>;
> > > +	status = "okay";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_usdhc4_1>;
> > > +};
> > > +
> > > +iomuxc at 020e0000 {
> > > +	compatible = "fsl,imx6q-iomuxc";
> > > +	reg = <0x020e0000 0x4000>;
> > > +
> > > +	/* shared pinctrl settings */
> > > +	usdhc4 {
> > > +		pinctrl_usdhc4_1: usdhc4grp-1 {
> > > +			fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
> > > +				    1392 0x17059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
> > > +				    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
> > > +				    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
> > > +				    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
> > > +				    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
> > > +				    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
> > > +				    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
> > > +				    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
> > > +				    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
> > honestly I don't like this it's obscure need to decode manually
> > 
> > I propose to use phandle
> > 
> > as example on uart you will want or not the rst/cts so you will have quite a
> > lot of bindings
> > 
> > so you can describe the pin configuration (function) and refer it by phandle
> > in the group
> > 
> Hmm, i can't say you're wrong.
> What you suggested may be suitable for your SoCs, before i know more about your SoC
> details, i may not comment too much.
> 
> The binding i used here basically follows the exist iomux v3 convention which we're
> using for non dt platforms, i think most people working on fsl platform may would
> want a similar using as before since iomux v3 is very easy to use for imx soc.
> You can refer to: iomux-mx51.h.
> 
> After dt macro support is available(which is still in progress), we may
> convert the raw data above to raw data then user do not need to decode
> the setting anymore.
this is not an excuse to duplicate bindings

Best Regards,
J.
