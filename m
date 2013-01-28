From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 19:57:47 +0000
Subject: [PATCH v5 07/14] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <CAHp75VeqikcTuOd14utb9E0P3b9t1mr=JsmkAbz5=3FJwU2kFA@mail.gmail.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <1358281974-8411-8-git-send-email-mporter@ti.com>
 <CAHp75VeqikcTuOd14utb9E0P3b9t1mr=JsmkAbz5=3FJwU2kFA@mail.gmail.com>
Message-ID: <201301281957.47604.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 January 2013, Andy Shevchenko wrote:
> On Tue, Jan 15, 2013 at 10:32 PM, Matt Porter <mporter@ti.com> wrote:
> > Adds a dma_request_slave_channel_compat() wrapper which accepts
> > both the arguments from dma_request_channel() and
> > dma_request_slave_channel(). Based on whether the driver is
> > instantiated via DT, the appropriate channel request call will be
> > made.
> >
> > This allows for a much cleaner migration of drivers to the
> > dmaengine DT API as platforms continue to be mixed between those
> > that boot using DT and those that do not.
> 
> Does it mean the introduced function is kinda temporary?

Some drivers can very likely get converted to use only
dma_request_slave_channel() in the long run, when all
the platforms using those drivers have been converted to
provide the channels using device tree.

However, for drivers that are used on legacy platforms
without DT support, we may still need something like
this function in the long run.

	Arnd
