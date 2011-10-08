From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 8 Oct 2011 11:23:13 +0100
Subject: [PATCH 06/26] ARM: pxa: add missing header inclusions
In-Reply-To: <20111008080309.GD25689@n2100.arm.linux.org.uk>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-7-git-send-email-arnd@arndb.de>
	<CAMPhdO8FGTw7NzNNjK819zF3GjrRX0ybPyaSFR4U7oG8cGmDtQ@mail.gmail.com>
	<20111008080309.GD25689@n2100.arm.linux.org.uk>
Message-ID: <20111008102313.GA4464@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2011 at 09:03:09AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 07, 2011 at 01:08:23PM +0800, Eric Miao wrote:
> > On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > These resulted in build breakage in some configurations:
> > >
> > > arch/arm/mach-pxa/irq.c:132:39: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'icip_handle_irq'
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > ?arch/arm/mach-pxa/irq.c | ? ?1 +
> > > ?1 files changed, 1 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> > > index b09e848..848e96d 100644
> > > --- a/arch/arm/mach-pxa/irq.c
> > > +++ b/arch/arm/mach-pxa/irq.c
> > > @@ -16,6 +16,7 @@
> > > ?#include <linux/module.h>
> > > ?#include <linux/interrupt.h>
> > > ?#include <linux/syscore_ops.h>
> > > +#include <linux/ftrace.h>
> > 
> > It's actually __irq_entry being defined in <linux/ftrace.h> and in turn
> > __exception_irq_entry being conditionally defined to that.
> > 
> > I think it's better to fix this in <asm/system.h> instead of in the
> > cases where this macro is referenced?
> > 
> > Russell?
> 
> There's a patch in the patch system which fixes this (7115/3) but I
> can't apply it because it doesn't apply to anything in my for-next
> tree (it applies to the obsolete 'devel' branch which is rather old
> now.)

OK, I wasn't aware that devel was obsolete (though I guess if I'd paid 
closer attention to the commit dates I'd have suspected something).

Anyhow, new patch in the tracker as 7115/4 rebased onto for-next.

Jamie
