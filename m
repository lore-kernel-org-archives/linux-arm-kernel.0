From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 May 2012 12:48:51 +0300
Subject: [RFC PATCH 10/11] omap4: thermal: add basic CPU thermal zone
In-Reply-To: <CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
 <CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
Message-ID: <20120528094850.GS18918@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 28, 2012 at 03:03:26PM +0530, Shilimkar, Santosh wrote:
> On Fri, May 25, 2012 at 1:56 PM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > This patch exposes OMAP4 thermal sensor as a thermal zone
> > named "cpu". Only thermal creation is done here.
> >
> > TODO:
> >
> > ?- Add cooling bindings
> > ?- Add extrapolation rules
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> > ?drivers/thermal/Kconfig ? ? ? ? | ? 12 ++++++
> > ?drivers/thermal/Makefile ? ? ? ?| ? ?1 +
> > ?drivers/thermal/omap-bandgap.c ?| ? ?1 +
> > ?drivers/thermal/omap-bandgap.h ?| ? 12 ++++++
> > ?drivers/thermal/omap4-thermal.c | ? 72 +++++++++++++++++++++++++++++++++++++++
> > ?5 files changed, 98 insertions(+), 0 deletions(-)
> > ?create mode 100644 drivers/thermal/omap4-thermal.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index ffdd240..2e82797 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -39,3 +39,15 @@ config OMAP_BANDGAP
> > ? ? ? ? ?This includes alert interrupts generation and also the TSHUT
> > ? ? ? ? ?support.
> >
> > +config OMAP4_THERMAL
> > + ? ? ? bool "Texas Instruments OMAP4 thermal support"
> > + ? ? ? depends on OMAP_BANDGAP
> > + ? ? ? depends on ARCH_OMAP4
> > + ? ? ? help
> > + ? ? ? ? If you say yes here you get thermal support for the Texas Instruments
> > + ? ? ? ? OMAP4 SoC family. The current chip supported are:
> > + ? ? ? ? ?- OMAP4460
> > +
> It's more of IP feature than OMAP specific, so something like
> 
> config  HAVE_BANDGAP_THERMAL_SUPPORT
> 
> and then let processor's which support enable it. That OMAP varients
> in AMXX etc if needed can make use of it.

Those are just an OMAP in disguise.

> If you agree, then rest of the driver also can be cleaned to avoid
> omap_* in file names and variables.
> 
> Apart from this minor comment, rest of the patch looks fine to me.

Then it will appear as a fully generic bandgap driver, which is not the
case. This is really a TI thing, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/077cf771/attachment-0001.sig>
