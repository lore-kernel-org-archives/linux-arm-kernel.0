From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 May 2017 11:15:04 +0200
Subject: [PATCH 10/11] crypto: sun4i-ss: fix large block size support
In-Reply-To: <20170529082931.ocoatlnpl7fvtgfu@flea.lan>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
 <20170524190652.13278-11-antoine.tenart@free-electrons.com>
 <20170526145501.GA19284@Red> <20170529080944.GA3169@kwain>
 <20170529082931.ocoatlnpl7fvtgfu@flea.lan>
Message-ID: <20170529091503.GB3169@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, May 29, 2017 at 10:29:31AM +0200, Maxime Ripard wrote:
> On Mon, May 29, 2017 at 10:09:44AM +0200, Antoine Tenart wrote:
> > > Which speed are the SS clocks ?
> > 
> > The AHB SS clk is running at 300 MHz and the SS clk at 150 MHz. SS clk
> > is at the expected rate but the AHB SS clk has a higher rate that what's
> > expected.
> > 
> > In the probing function only the SS clk rate is explicitly set. I tried
> > to set the AHB clk rate as well and removed the delays. This didn't fix
> > the framework selftests at boot time. Is there any reason the AHB SS clk
> > rate isn't explicitly set when probing the driver? (Should it?)
> 
> It probably shouldn't.
> 
> The AHB clock is shared by most of the drivers, some of them actually
> using that clock to generate their signals.
> 
> You would have to unbreak all those drivers first, which is probably
> not needed at all. I haven't seen a case where a block had a module
> clock and did care for its AHB clock rate.

OK, makes sense.

I'll wait for Corentin to test the series, and I'll send a v2 only
fixing the typos then.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/2b8c7fd5/attachment.sig>
