From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 25 Jan 2018 11:31:40 +0100
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <278bb44610b8a27826550732095aba03@codeaurora.org>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
 <20180123103931.GE27764@dragon>
 <278bb44610b8a27826550732095aba03@codeaurora.org>
Message-ID: <1516876300.6411.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.01.2018, 18:10 +0800 schrieb aisheng.dong at codeaurora.org:
> On 2018-01-23 18:39, Shawn Guo wrote:
> > On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:
> > 
> > > > > > +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> > > > > > +		fsl,pins = <
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
> > > > > > > > > +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> > > > > > +		>;
> > > +		};
> > 
> > Bad indentation.
> > 
> > Shawn
> > 
> > > +
> > > > > > +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> > > > > > +		fsl,pins = <
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
> > > > > > > > > +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> > > > > > +		>;
> > > +	};
> 
> AFAIK we switched to generic pinconfig since MX7ULP as maintainer won't
> access old binding pinctrl drivers.

I'm not convinced that the generic pinconf is good fit. For pingroups
with different configs for some of the pins, like the example above, we
would need to split things into multiple DT nodes. This really hurts
readability, so I'm not going to switch to the generic stuff without
some really convincing arguments.

Regards,
Lucas
