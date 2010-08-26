From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 26 Aug 2010 19:00:24 +0900
Subject: [RFC][PATCH] add
	dma_reserve_coherent_memory()/dma_free_reserved_memory() API
In-Reply-To: <20100826095311.GA13051@pengutronix.de>
References: <Pine.LNX.4.64.1008261100150.14167@axis700.grange>
	<20100826182915S.fujita.tomonori@lab.ntt.co.jp>
	<20100826095311.GA13051@pengutronix.de>
Message-ID: <20100826185938A.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 11:53:11 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> > > We have currently a number of boards broken in the mainline. They must be 
> > > fixed for 2.6.36. I don't think the mentioned API will do this for us. So, 
> > > as I suggested earlier, we need either this or my patch series
> > > 
> > > http://thread.gmane.org/gmane.linux.ports.sh.devel/8595
> > > 
> > > for 2.6.36.
> > 
> > Why can't you revert a commit that causes the regression?
> > 
> > The related DMA API wasn't changed in 2.6.36-rc1. The DMA API is not
> > responsible for the regression. And the patchset even exnteds the
> > definition of the DMA API (dma_declare_coherent_memory). Such change
> > shouldn't applied after rc1. I think that DMA-API.txt says that
> > dma_declare_coherent_memory() handles coherent memory for a particular
> > device. It's not for the API that reserves coherent memory that can be
> > used for any device for a single device.
> The patch that made the problem obvious for ARM is
> 309caa9cc6ff39d261264ec4ff10e29489afc8f8 aka v2.6.36-rc1~591^2~2^4~12.
> So this went in before v2.6.36-rc1.  One of the "architectures which
> similar restrictions" is x86 BTW.
> 
> And no, we won't revert 309caa9cc6ff39d261264ec4ff10e29489afc8f8 as it
> addresses a hardware restriction.

How these drivers were able to work without hitting the hardware restriction?
