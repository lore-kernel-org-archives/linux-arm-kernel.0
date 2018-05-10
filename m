From: ping.bai@nxp.com (Jacky Bai)
Date: Thu, 10 May 2018 01:53:10 +0000
Subject: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
In-Reply-To: <ae5b239a57bd7e3f3e62cc23a1c3788e@agner.ch>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
 <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
 <HE1PR04MB3113135433766196E708685887990@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <ae5b239a57bd7e3f3e62cc23a1c3788e@agner.ch>
Message-ID: <HE1PR04MB311361C15FDC2EAE3AA1FE3587980@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
> 
> On 09.05.2018 03:26, Jacky Bai wrote:
> >> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate
> >> change
> >>
> >> Quoting Stefan Agner (2018-05-08 06:20:03)
> >> > On 08.05.2018 09:32, Jacky Bai wrote:
> >> > >
> >> > > I have tried two 6ULL board, I don't meet such issue. System can
> >> > > boot up successfully with commit 6f9575e55632 included.
> >> > > Anyway, the change in this patch is ok for me. it is no harm to
> >> > > the BUS clock change flow.
> >> >
> >> > Hm, that is interesting, maybe it is because we use a different SKU?
> >> > Or maybe bootloader?
> >> >
> >> > I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL
> >> > using U-Boot 2016.11.
> >> >
> >>
> >> I'll throw this into fixes today because it fixes something to be
> >> useful. It's still interesting to see what's different between the two setups
> though.
> >
> > Thanks.
> >
> > I will find some 800MHz parts and have a try with different bootloader later.
> > Will let you know, when I have some results.
> >
> 
> FWIW, I tried two SKUs here:
> MCIMX6Z2DVM05AA (528Mhz)
> MCIMX6Z2CVM08AA (800MHz)
> 

 MCIMX6Z or  MCIMX6Y ? I think i.MX6ULL should be 6Y.

Jacky

> Both run at 396MHz in U-Boot, and both freeze and the same location.
> 
> --
> Stefan
