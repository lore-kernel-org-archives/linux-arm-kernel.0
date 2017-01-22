From: ping.bai@nxp.com (Jacky Bai)
Date: Sun, 22 Jan 2017 02:14:35 +0000
Subject: [PATCH v2 04/12] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <20170121010009.GC8801@codeaurora.org>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
 <20170110003753.GM17126@codeaurora.org>
 <AM3PR04MB5307CB38AA904535AF8D80D87670@AM3PR04MB530.eurprd04.prod.outlook.com>
 <20170112220536.GP17126@codeaurora.org>
 <AM3PR04MB53027B627AE8CEC6D7D0D1B87780@AM3PR04MB530.eurprd04.prod.outlook.com>
 <20170121010009.GC8801@codeaurora.org>
Message-ID: <AM3PR04MB530CDCAC082173FDDDFEEFA87730@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > The reason why we enable these two clks here is in below commit
> > > > commit
> > > > a5120e89e7e187a91852896f586876c7a2030804
> > > > Author: Peter Chen <peter.chen@freescale.com>
> > > > Date:   Fri Jan 18 10:38:05 2013 +0800
> > > >       ARM i.MX6: change mxs usbphy clock usage
> > > >
> > >
> > > So can we mark these clks with CLK_IS_CRITICAL flag then instead?
> > > Or are they disabled out of the bootloader?
> > >
> >
> > Sure, using 'CLK_IS_CRITICAL'  should be ok for clks_init_on clocks.
> > But for  USBPHY*_GATE, it is only enabled when CONIG_USB_MXC_PHY is
> > true.  And another concern is if we need to add CLK_IS_CRITICAL flag to
> clks_init_on clocks, we may need to add new wrapper function to register
> these critical clock. It is not very good.
> 
> Ok so set the critical flag when CONFIG_USB_MXC_PHY is enabled?
> That isn't too hard to do.
> 

Ok, thanks, I will address this in V3.

> > 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project
