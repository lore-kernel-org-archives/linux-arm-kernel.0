From: balbi@ti.com (Felipe Balbi)
Date: Thu, 1 Oct 2015 17:30:14 -0500
Subject: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
In-Reply-To: <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
 <CALAqxLVUDYivs4QKWtFDbwFdWqa2JJX49Aj15p69zpYCb1_SbA@mail.gmail.com>
Message-ID: <20151001223014.GD32355@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 03:20:18PM -0700, John Stultz wrote:
> On Tue, Sep 29, 2015 at 1:44 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Introduce a new clocksource driver for Texas
> > Instruments 32.768 Hz device which is available
> > on most OMAP-like devices.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/clocksource/Kconfig        |   8 +++
> >  drivers/clocksource/Makefile       |   1 +
> >  drivers/clocksource/timer-ti-32k.c | 121 +++++++++++++++++++++++++++++++++++++
> 
> Also isn't this somewhat duplicate of the code in
> arch/arm/plat-omap/counter_32k.c ?
> 
> Was this really a rewrite or just a code migration? Should you

migrating, but we can't really delete that yet because we still have
a bunch of legacy platforms not using DT.

> preserve the copyrights from counter_32k.c?

heh, probably :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/b3fd6814/attachment.sig>
