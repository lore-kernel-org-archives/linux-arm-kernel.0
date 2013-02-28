From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Feb 2013 10:50:21 +0000
Subject: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
In-Reply-To: <20130228082831.GG26106@S2101-09.ap.freescale.net>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <201302272054.18829.arnd@arndb.de>
 <20130228082831.GG26106@S2101-09.ap.freescale.net>
Message-ID: <201302281050.21522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 February 2013, Shawn Guo wrote:
> On Wed, Feb 27, 2013 at 08:54:18PM +0000, Arnd Bergmann wrote:
> > On Wednesday 27 February 2013, Shawn Guo wrote:
> >
> > I wonder if we should leave support for old device trees files around,
> > at least for a while. Your patch removes a lot of unnecessary code if
> > we decide not to worry about backwards compatibility here, but I could
> > imagine that we see a few surprises here.
> > 
> I'm less concerned by that at this point.  Though platform mxs has been
> fully converted to device tree, device tree is still quite new for the
> platform.  The incompatible device tree should be acceptable,
> considering we have noticed that when adding the temporary DMA binding
> for client devices.
> 
> /*
>  * TODO: This is a temporary solution and should be changed
>  * to use generic DMA binding later when the helper get in.
>  */
> 
> Unless we have these TODO remarks leave in the tree forever, we will
> break old device tree sooner or later anyway.  And I would have it
> happen sooner than later.
> 
> And I would start thinking about maintaining the device tree
> compatibility for mxs after generic DMA binding adoption.

Right. It's your decision anyway, and removing the code as early
as possible has some advantages as well.

	Arnd
