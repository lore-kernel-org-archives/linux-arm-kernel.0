From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 11:35:11 +0200
Subject: [PATCH 1/5] ARM: ux500: Move DMA40 platform data includes file
 out to include/
In-Reply-To: <20130409070558.GG3084@gmail.com>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <201304081817.42031.arnd@arndb.de> <20130409070558.GG3084@gmail.com>
Message-ID: <201304091135.11427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> On Mon, 08 Apr 2013, Arnd Bergmann wrote:
> 
> > On Monday 08 April 2013, Lee Jones wrote:
> > > The pin names for DB8500 based platforms need to be moved out of
> > > ux500 platform data and into the new proper location in include/
> > > linux/platform_data/. This way we an reference them from other
> > > external locations, such as the main DMA50 driver(s).
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Hmm, not sure about this one. The slave numbers are not really platform_data
> > and I think they should not be exposed to drivers. It makes sense to
> > keep the numbers for the memcpy channels in the driver itself as they
> > are hardwired in the driver, but the slave channels should stay in the
> > platform I think.
> 
> Just looking at this again now. So you're right in that the main
> reason for moving these out of platform code and into the system-wide
> platform data area is for the memcpy channels. However, I'd prefer to
> keep the channel allocation enum fully contiguous rather than
> splitting them out.
> 
> The channels are only exposed to the one external driver which
> includes them, and that's the D40 driver.
> 
> How against this move are you?

I think it's a move in the wrong direction. If you think we should keep the
knowledge of which channels are used for memcpy outside of the driver,
I would prefer you to drop the the first two patches, which implies that
we will eventually pass that information using DT properties in order get
rid of the auxdata.

	Arnd
