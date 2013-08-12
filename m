From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Aug 2013 13:41:23 +0200
Subject: [PATCH V4 1/4] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <20130812113447.GW6427@sirena.org.uk>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
 <21180092.af8YMiXtjc@amdc1227> <20130812113447.GW6427@sirena.org.uk>
Message-ID: <3916118.YsNJ4NTaJS@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 of August 2013 12:34:48 Mark Brown wrote:
> On Mon, Aug 12, 2013 at 01:14:20PM +0200, Tomasz Figa wrote:
> > On Monday 12 of August 2013 15:37:47 Padmavathi Venna wrote:
> > > +	i2s_0: i2s at 03830000 {
> > > +		status = "disabled";
> > 
> > If a node does not require any board-specific properties for the device
> > to operate properly, there is no point in disabling it, just to add a
> > single status property at board level.
> 
> I'd expect that to interact badly with the pinmuxing - unless the device
> is disabled it'll try to grab its pins on probe which is not going to be
> a good idea unless it is actually wired up for use in the system.  Or is
> there some other mechanism for handling that?

Ah, good point. Now I wonder whether pinctrl nodes shouldn't be considered 
board-specific and specified in board-level dts instead?

Best regards,
Tomasz
