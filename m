From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Mar 2013 10:58:04 +0100
Subject: [PATCH v2 10/11] ARM i.MX53: Add LDB device to device tree
In-Reply-To: <5154023F.600@parkeon.com>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-11-git-send-email-p.zabel@pengutronix.de>
 <51533DDC.2030401@parkeon.com>
 <20130328073212.GM5429@S2101-09.ap.freescale.net>
 <5154023F.600@parkeon.com>
Message-ID: <1364464684.4018.30.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 28.03.2013, 09:41 +0100 schrieb Martin Fuzzey:
> On 28/03/13 08:32, Shawn Guo wrote:
> > On Wed, Mar 27, 2013 at 07:43:40PM +0100, Martin Fuzzey wrote:
> >>
> >> Maybe pinctrl entries should also be added?
> > Generally, the pinctrl entries should be added in <board>.dts.
> 
> Yes sorry I meant the pinctrl groups under the iomuxc node.

I'm not fond of putting each and every possible pin group configuration
into the dtsi. But since there is only one possibility to multiplex each
of the LVDS0 and LVDS1 pads on i.MX53, I wouldn't resist:

ldb {
	pinctrl_lvds0_1: lvds0grp-1 {
		fsl,pins = <
			730 0x80000000	/* MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3 */
			732 0x80000000	/* MX53_PAD_LVDS0_CLK_P__LDB_LVDS0_CLK */
			734 0x80000000	/* MX53_PAD_LVDS0_TX2_P__LDB_LVDS0_TX2 */
			736 0x80000000	/* MX53_PAD_LVDS0_TX1_P__LDB_LVDS0_TX1 */
			738 0x80000000	/* MX53_PAD_LVDS0_TX0_P__LDB_LVDS0_TX0 */
		>;
	};

	pinctrl_lvds1_1: lvds1grp-1 {
		fsl,pins = <
			720 0x80000000	/* MX53_PAD_LVDS1_TX3_P__LDB_LVDS1_TX3 */
			722 0x80000000	/* MX53_PAD_LVDS1_TX2_P__LDB_LVDS1_TX2 */
			724 0x80000000	/* MX53_PAD_LVDS1_CLK_P__LDB_LVDS1_CLK */
			726 0x80000000	/* MX53_PAD_LVDS1_TX1_P__LDB_LVDS1_TX1 */
			728 0x80000000	/* MX53_PAD_LVDS1_TX0_P__LDB_LVDS1_TX0 */
		>;
	};
};

regards
Philipp
