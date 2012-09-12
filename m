From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Sep 2012 15:55:47 +0100
Subject: [RFC PATCH] ARM: mm: ADD descriptor string to
 CONFIG_DMA_ADDR_64BIT_T
In-Reply-To: <CAJ7qFSeYu3OncDwSRcvYmjha7xUzoj3JSBy49OjELkPOSeZcdA@mail.gmail.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
 <5050841A.7030203@ti.com>
 <CAMQu2gzpiZ8Qa8eGprCscmhFa1zW4Bb4ZEVR=e56tXBSE1pGWQ@mail.gmail.com>
 <CAJ7qFSeYu3OncDwSRcvYmjha7xUzoj3JSBy49OjELkPOSeZcdA@mail.gmail.com>
Message-ID: <20120912145547.GE28448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 06:50:00PM +0530, R, Sricharan wrote:
> Hi,
> On Wed, Sep 12, 2012 at 6:27 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > On Wed, Sep 12, 2012 at 6:16 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> >>
> >> On 9/12/2012 1:50 AM, R Sricharan wrote:
> >>>
> >>> Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
> >>> the feature is not getting selected.
> >>> Adding a string description in the Kconfig resolves this.
> >>>
> >>> But not sure if this is the right way to fix this.
> >>>
> >>
> >> Shouldn't you be selecting this in your 64-bit dma address capable arch
> >> instead?
> >>
> > Yes. The selection to enable  CONFIG_DMA_ADDR_64BIT_T happens
> > in the arch which needs it. Since this option was made as simple bool,
> > looks like because of some KCONFIG magic, it was not getting selected.
> > Adding some help text does fix the issue and thats is the patch all about.
> >
>   Correct. So even if you select this in the arch/defconfig,

That is correct behaviour.

You need an explicit "select DMA_ADDR_64BIT_T" somewhere in a Kconfig file
to make it happen.

Editing defconfigs is not how we enable these options.
