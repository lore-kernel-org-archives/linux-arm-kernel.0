From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 09:19:45 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <50A6946D.3030006@mpl.ch>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116151128.GO22106@titan.lakedaemon.net>
 <50A6946D.3030006@mpl.ch>
Message-ID: <20121117081945.GE24569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static unsigned int mplcec4_mpp_config[] __initdata = {
> >> +	MPP0_NF_IO2,
> >> +	MPP1_NF_IO3,
> >> +	MPP2_NF_IO4,
> >> +	MPP3_NF_IO5,
> >> +	MPP4_NF_IO6,
> >> +	MPP5_NF_IO7,
> >> +	MPP6_SYSRST_OUTn,
> >> +	MPP7_GPO,	/* Status LED Green High Active */
> >> +	MPP10_UART0_TXD,
> >> +	MPP11_UART0_RXD,
> >> +	MPP12_SD_CLK,
> >> +	MPP13_SD_CMD,	/* Alt UART1_TXD */
> >> +	MPP14_SD_D0,	/* Alt UART1_RXD */
> >> +	MPP15_SD_D1,
> >> +	MPP16_SD_D2,
> >> +	MPP17_SD_D3,
> >> +	MPP18_NF_IO0,
> >> +	MPP19_NF_IO1,
> >> +	MPP28_GPIO,	/* Input SYS_POR_DET (active High) */
> >> +	MPP29_GPIO,	/* Input SYS_RTC_INT (active High) */
> >> +	MPP34_SATA1_ACTn,
> >> +	MPP35_SATA0_ACTn,
> >> +	MPP40_GPIO,	/* LED User1 orange */
> >> +	MPP41_GPIO,	/* LED User1 green */
> >> +	MPP44_GPIO,	/* LED User0 orange */
> >> +	MPP45_GPIO,	/* LED User0 green */
> >> +	MPP46_GPIO,	/* Status LED Yellow High Active */
> >> +	MPP47_GPIO,	/* SD_CD# (in/IRQ)*/
> >> +	0
> >> +};
> > 
> > We're this to DT during this merge window, but don't worry about
> > changing it.  We'll be doing a cleanup patch to catch the new boards.
> > If you could just keep an eye out for it and test, it would be
> > appreciated.
> 
> 
> If you can point me to the appropriate tree, I'd like to try to do this
> myself. I could even rebase the CEC4 patch to this tree if you prefer.

You can take a look at 

git://github.com/lunn/linux.git v3.7-rc2-pinctrl-v2

These patches have been on the list once, maybe twice. I will be
posting them again soon, maybe in a different order.

Jason also has a patch from me which converts the ehci setup to device
tree. With that patch in place, you just need to drop the
kirkwood_ehci_init().


	Andrew
