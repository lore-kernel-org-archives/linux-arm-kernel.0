From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 16:34:37 +0100
Subject: [PATCH 03/15] soc: renesas: Add R-Car M3-N support
In-Reply-To: <CAMuHMdU-pYNwjrXSR7j2kNkJSYsKd=0Kf0Tzq5LHpwA7p4_9MA@mail.gmail.com>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdU-pYNwjrXSR7j2kNkJSYsKd=0Kf0Tzq5LHpwA7p4_9MA@mail.gmail.com>
Message-ID: <20180215153436.77h46poeswto53lm@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 01:48:27PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> Thanks for your patch!
> 
> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add support for R-Car M3-N (r8a77965) power areas and reset.
> > M3-N power areas are identical to M3-W ones, so just copy and rename
> > them.
> 
> They are not identical:
>   - M3-N does not have the CA53-related areas,
>   - M3-W does not have A3VP,
>   - M3-N does not have A2VC0 (M3-W also doesn't, according to latest
> datasheet?).
> 
> The datasheet also mentions A3SH, without further info about the register
> block. I think we need to bring this up with Renesas.
> 
> >  .../bindings/power/renesas,rcar-sysc.txt           |  1 +
> >  .../devicetree/bindings/reset/renesas,rst.txt      |  1 +
> >  drivers/soc/renesas/Kconfig                        |  9 ++++--
> >  drivers/soc/renesas/Makefile                       |  1 +
> >  drivers/soc/renesas/r8a77965-sysc.c                | 37 ++++++++++++++++++++++
> >  drivers/soc/renesas/rcar-rst.c                     |  1 +
> >  drivers/soc/renesas/rcar-sysc.c                    |  3 ++
> >  drivers/soc/renesas/rcar-sysc.h                    |  1 +
> >  drivers/soc/renesas/renesas-soc.c                  |  8 +++++
> >  include/dt-bindings/power/r8a77965-sysc.h          | 31 ++++++++++++++++++
> >  10 files changed, 91 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
> >  create mode 100644 include/dt-bindings/power/r8a77965-sysc.h
> 
> The maintainer may ask you to split this patch by functionality...

Yes, I would like this split up.

I think "[PATCH 00/11] Add R8A77980/Condor board support" provides
a good example.
