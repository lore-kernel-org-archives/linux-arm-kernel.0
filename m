From: aisheng.dong@codeaurora.org (Dong Aisheng)
Date: Thu, 25 Jan 2018 18:49:19 +0800
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <1516876300.6411.25.camel@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
 <20180123103931.GE27764@dragon>
 <278bb44610b8a27826550732095aba03@codeaurora.org>
 <1516876300.6411.25.camel@pengutronix.de>
Message-ID: <2cac219f031a08ae2ac02a0624fe302f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-25 18:31, Lucas Stach wrote:
> Am Donnerstag, den 25.01.2018, 18:10 +0800 schrieb 
> aisheng.dong at codeaurora.org:
>> On 2018-01-23 18:39, Shawn Guo wrote:
>> > On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:
>> >
>> > > > > > +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> > > > > > +		fsl,pins = <
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
>> > > > > > > > > +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
>> > > > > > +		>;
>> > > +		};
>> >
>> > Bad indentation.
>> >
>> > Shawn
>> >
>> > > +
>> > > > > > +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> > > > > > +		fsl,pins = <
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
>> > > > > > > > > +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
>> > > > > > > > > +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
>> > > > > > +		>;
>> > > +	};
>> 
>> AFAIK we switched to generic pinconfig since MX7ULP as maintainer 
>> won't
>> access old binding pinctrl drivers.
> 
> I'm not convinced that the generic pinconf is good fit. For pingroups
> with different configs for some of the pins, like the example above, we
> would need to split things into multiple DT nodes. This really hurts
> readability, so I'm not going to switch to the generic stuff without
> some really convincing arguments.
> 

Per my understanding, based on the last discussion with Linus W, we 
actually
did this in order to increase the readability that 1) user does not need 
to
see the 'ugly' unreadable raw data and refer to reference manual 2) 
unified
generic binding format which already exist in kernel and used by many
platforms.

Actually MXS platform already used it for many years in a similar way.

So IMHO a little hurt to add another node for different pad setting in 
the
same group won't be enough reason to stop switching to generic config.

Does it make sense?

Regards
Dong Aisheng

> Regards,
> Lucas
