From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 18:04:43 +0200
Subject: [PATCH v8 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140521155551.GV27329@lukather>
References: <1400685357-508-1-git-send-email-maxime.ripard@free-electrons.com>
 <4828893.NoTbcUXQEt@wuerfel> <20140521155551.GV27329@lukather>
Message-ID: <5291281.0OW8pVdbhQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 17:55:51 Maxime Ripard wrote:
> On Wed, May 21, 2014 at 05:23:41PM +0200, Arnd Bergmann wrote:
> > On Wednesday 21 May 2014 17:15:54 Maxime Ripard wrote:
> > > Changes from v7:
> > >   - select DMA_OF, since we're only relying on DT
> > > 
> > 
> > I missed the discussion about this issue, but it seems wrong to me.
> > DMA_OF is currently enabled if we have both DMAENGINE and OF turned on.
> > 
> > If OF is disabled but DMA_OF gets selected by DMA_SUN6I, what happens?
> 
> Is that even possible with a multiplatform-based platform?

It's not possible for ARCH_SUNXI or any other that depends on
ARCH_MULTIPLATFORM. I just noticed that you have 'depends on ARCH_SUNXI',
so the 'select DMA_OF' statement is just redundant, not wrong.

However, if the driver was 'depends on ARCH_SUNXI || COMPILE_TEST' as many
others are nowadays, it would be a bug.

	Arnd
