From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 8 May 2015 14:34:14 -0700
Subject: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
In-Reply-To: <554D24DA.8060601@wwwdotorg.org>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
 <CAMuHMdXeen3cU2bb8TXxxtdDjgMCU_FS1Yxdu1b-Tq2xE+x0ZA@mail.gmail.com>
 <554D24DA.8060601@wwwdotorg.org>
Message-ID: <20150508213414.GE32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 03:04:26PM -0600, Stephen Warren wrote:
> On 05/08/2015 02:57 PM, Geert Uytterhoeven wrote:
> >On Fri, May 8, 2015 at 8:43 PM, Brian Norris
> ><computersforpeace@gmail.com> wrote:
> >>On Fri, May 08, 2015 at 10:00:12AM -0600, Stephen Warren wrote:
> >>>On 05/08/2015 12:21 AM, Rafa? Mi?ecki wrote:
> >>>>Starting with commits
> >>>>8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
> >>>>1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
> >>>>we have "nor-jedec" binding indicating support for JEDEC identification.
> >>>
> >>>The documentation looks quite incomplete. "nor-jedec" sounds like
> >>>it's intended to be something generic. As such, it should be
> >>>documented in e.g.
> >>>Documentation/devicetree/bindings/mtd/nor-jedec.txt, not buried in
> >>>one particular flash device's binding. If it's not intended to be
> >>>generic, why isn't the existing "winbond,w25q32dw" enough?
> >>
> >>It is generic, though there are plenty of additional manufacturer/device
> >>pairs that could go on top of it. m25p80 was (one of?) the first
> >>supported, so the naming has been based on legacy, and we're in the
> >>process of unwinding a bit of that. If it helps, we could move the doc
> >>to .../mtd/spi-nor,nor-jedec.txt or something like that.
> >>
> >>>Equally, "nor-jedec" doesn't sound like the right name. It doesn't
> >>>differentiate between SPI and parallel NOR flash, which presumably
> >>>need different compatible values, since the programming model is
> >>>quite different, and the compatible value is supposed to
> >>>define/imply the SW-visible programming model.
> >>
> >>It's definitely for SPI only. There was much discussion about this a
> >>few months back. Somewhere along the way, it was mentioned that the
> >>context (SPI slave is a child of SPI master) would make this clear. I'm
> >>still not sure why we didn't end up with something more descriptive,
> >>though, like "spi-nor,nor-jedec".
> >
> >What about "jedec,spi-nor"?
> 
> That seems unique enough to me, or the options below if they're
> actually applicable.

That could be OK with me. If I can get the magic blessing from the DT
folks, then I'll send patches to update everything.

> >Is this "SERIAL FLASH DISCOVERABLE PARAMETERS (SFDP)"?
> >https://www.jedec.org/standards-documents/docs/jesd216b
> >(Don't have time to register with jedec now...)
> >
> >If yes, "jedec,sfdp"? "jedec,jesd216b"?

It's not SFDP. We're looking at SPI flash that are detected simply by
the READ ID (9Fh) opcode. SFDP is on newer SPI flash which support the
5Ah opcode, for reading a parameter table. (I'd like to support this
soon, actually, and one of those sorts of strings might work.)

Brian
