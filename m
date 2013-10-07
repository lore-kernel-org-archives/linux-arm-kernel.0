From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 19:03:57 +0100
Subject: [PATCH RFC 1/2] ARM: imx6qdl: provide pinctrl configurations
 for DAT3 pull-down
In-Reply-To: <20131007055340.GB3739@S2101-09.ap.freescale.net>
References: <20131005112147.GX12758@n2100.arm.linux.org.uk>
 <E1VSPw9-0004Ug-BF@rmk-PC.arm.linux.org.uk>
 <20131007055340.GB3739@S2101-09.ap.freescale.net>
Message-ID: <20131007180357.GS12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 01:53:43PM +0800, Shawn Guo wrote:
> I think we can redefine only pad DAT3 in pinctrl_usdhc1_1_dat3cd, and
> overwrite the DAT3 configuration in pinctrl_usdhc1_1 to save the
> redundant data of other pads, something like the following.
> 
> pinctrl_usdhc1_1_dat3cd: usdhc1grp-3 {
> 	fsl,pins = <
> 		MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
> 	>;
> };
> 
> &usdhc1 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd>;
> 	...
> 	status = "okay";
> };

Are you sure that this will always be the case?  This would assume that
the pinctrl entries are always processed sequentially.
