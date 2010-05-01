From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 10:44:36 +0100
Subject: [PATCH] ARM: Add support for 10 hardirq bits
In-Reply-To: <u2yaec7e5c31004292102rd561d7detc73e9fd2a5570ab0@mail.gmail.com>
References: <20100310111749.18521.9002.sendpatchset@t400s>
	<u2yaec7e5c31004292102rd561d7detc73e9fd2a5570ab0@mail.gmail.com>
Message-ID: <20100501094436.GC12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 01:02:04PM +0900, Magnus Damm wrote:
> On Wed, Mar 10, 2010 at 8:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm@opensource.se>
> >
> > This patch adds support for 10 hardirq bits to
> > the ARM architecture. Needed by the SH-Mobile
> > ARM processor sh7372 that has more than 512 IRQs.
> >
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> >
> > ?arch/arm/include/asm/hardirq.h | ? ?4 +++-
> > ?1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > --- 0001/arch/arm/include/asm/hardirq.h
> > +++ work/arch/arm/include/asm/hardirq.h 2010-03-09 21:08:10.000000000 +0900
> > @@ -12,7 +12,9 @@ typedef struct {
> >
> > ?#include <linux/irq_cpustat.h> /* Standard mappings for irq_cpustat_t above */
> >
> > -#if NR_IRQS > 256
> > +#if NR_IRQS > 512
> > +#define HARDIRQ_BITS ? 10
> > +#elif NR_IRQS > 256
> > ?#define HARDIRQ_BITS ? 9
> > ?#else
> > ?#define HARDIRQ_BITS ? 8
> >
> 
> Hi Russell,
> 
> Good to hear that you are back online. Do you want me to rework this
> patch somehow, or is it ready to be queued for upstream merge? I'm
> asking because I have a pile of patches that depend on this one.

I guess it's ok; with 10 bits we're at the maximum which the generic
kernel supports (see linux/hardirq.h)
