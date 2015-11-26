From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Nov 2015 12:46:31 +0900
Subject: [PATCH v5 0/4] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
In-Reply-To: <CAMuHMdXeb-hWhAXFtKDpnc_nuBgzi7usxPOmKY9kNmwM4A+54w@mail.gmail.com>
References: <1448286962-16897-1-git-send-email-geert+renesas@glider.be>
 <20151125015048.GN20596@verge.net.au>
 <CAMuHMdXeb-hWhAXFtKDpnc_nuBgzi7usxPOmKY9kNmwM4A+54w@mail.gmail.com>
Message-ID: <20151126034628.GA1198@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 09:45:20AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Nov 25, 2015 at 2:50 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Nov 23, 2015 at 02:55:58PM +0100, Geert Uytterhoeven wrote:
> >> This patch series add minimal L1 and L2 cache descriptions to DT for
> >> r8a7740 and sh73a0, and migrates the shmobile DT-based generic r8a7740
> >> platform from calling l2x0_of_init() to the generic l2c OF
> >> initialization.
> >>
> >> Note that the conversion to the generic l2c OF initialization is not
> >> done yet for sh73a0, as this initializes the L2 cache earlier, breaking
> >> the (fragile) sh73a0 secondary CPU bringup code.
> >>
> >> Also note that this conversion should be done on r8a7778, and r8a7779,
> >> too.
> >
> > Based on your work I have prepared a DT patch for the r8a7779.
> 
> Thanks for following up.
> 
> > I don't think that a C patch is necessary, please correct me if I am wrong.
> 
> Yes you do!
> Without machine_desc.l2x_aux_{val,mask}, the information in DT is not used.
> Cfr. arch/arm/mach-shmobile/setup-r8a7740.c

Thanks, I see "ARM: shmobile: r8a7740: Migrate to generic l2c OF
initialization" with new eyes.

> > Regarding the r8a7778: My reading of the documentation is that although a
> > pl310 L2 cache controller is present it is not available for use as there
> > is no L2 cache memory present. For this reason I do not think any patches
> > are required for the r8a7798.
> 
> I agree after consulting the datasheet.
> 
> >> Dependencies:
> >>   - This series applies to renesas-devel-20151123-v4.4-rc2,
> >>   - Patch 3 depends on patch 1,
> >>   - Patch 4 depends on patch 3.
> >>
> >> Given C code changesets depending on DT changesets in the same branch
> >> are frowned upon, you may want to postpone patches 3 and 4 to v4.6.
> >> Of course I'll sleep better if you just apply all 4 of them now ;-)
> >
> > I have queued up the DT changes for v4.5.
> > And tentatively queued up the C changes for v4.6.
> 
> Thank you!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
