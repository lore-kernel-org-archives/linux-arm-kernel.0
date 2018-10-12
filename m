From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 12 Oct 2018 11:23:14 -0700
Subject: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through
 a pdev
In-Reply-To: <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22> <51066716.k5MkZnrqCl@avalon>
 <1531908387.8953.147.camel@mtkswgap22>
 <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
Message-ID: <153936859491.5275.13670768818136325103@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2018-07-26 00:35:14)
> Quoting Sean Wang (2018-07-18 03:06:27)
> > On Wed, 2018-07-18 at 11:05 +0300, Laurent Pinchart wrote:
> > > Hi Sean,
> > > 
> > > This looks very strange to me. I'm not familiar with the hardware 
> > > architecture, but a clock controller that includes an audio controller seems 
> > > like a very weird design. It's usually the other way around, you have an audio
> > 
> > yes, naming audsys as clock controller is really not good. it should be
> > worth a better naming.
> > 
> > mtk subsystem AFAIK works as a container, at least provides clocks,
> > reset, syscon access, these common resource to these devices running on
> > the subsystem. It also has a power gate independent from other
> > subsystem, that can be controlled when these devices all powered down
> > or once up.
> > 
> > And it should be better that we don't assume what exact devices are
> > running on since it is possible that there're different devices running
> > on the same subsystem per SoC. mtk has many subsystem working in this
> > way. mmsys is just a case. we can see in [1]
> > 
> > 
> > [1]
> > https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/devicetree/bindings/arm/mediatek
> >  
> 
> Sean, is this an ack for this patch series? I think the consensus is to
> not modify DT to add a subnode for the "clk" part of the hardware, but
> instead either register the clks from the device driver that has the clk
> hardware inside of it, or do what this patch series does and register a
> device in software from the "parent" device driver so that logically clk
> things are contained in drivers/clk/
> 

Please resend this series. This is too old now and I'm dropping this
from (the very tail) of my queue.
