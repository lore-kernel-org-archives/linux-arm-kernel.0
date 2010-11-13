From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Nov 2010 13:15:37 +0000
Subject: [PATCH 2.6.36 1/1] kernel SPIN_LOCK_UNLOCKED changed to
	__SPIN_LOCK_UNLOCKED()
In-Reply-To: <4CDE7D65.6060203@gmail.com>
References: <4CD823DC.8030201@gmail.com> <4CDE7D65.6060203@gmail.com>
Message-ID: <20101113131537.GB26105@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 13, 2010 at 05:28:29PM +0530, Atul Sowani wrote:
> Atul Sowani wrote:
> > There are still some files containing .lock = SPIN_LOCK_UNLOCKED type
> > assignments which should be converted to __SPIN_LOCK_UNLOCKED().
> > 
> > Signed-off-by: Atul Sowani <sowani@gmail.com>
> > ---
> > 
> > diff -uprN a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > --- a/arch/arm/kernel/smp.c	2010-10-21 02:00:22.000000000 +0530
> > +++ b/arch/arm/kernel/smp.c	2010-11-07 00:47:32.000000000 +0530
> > @@ -56,7 +56,7 @@ struct ipi_data {
> >  };
> > 
> >  static DEFINE_PER_CPU(struct ipi_data, ipi_data) = {
> > -	.lock	= SPIN_LOCK_UNLOCKED,
> > +	.lock	= __SPIN_LOCK_UNLOCKED (ipi_data.lock),

No space between UNLOCKED and (.

> I made original patch submission on 08.Nov.2010. I am wondering if
> this patch will be useful and is correct. Please comment.

This is the first I've seen of this patch.  For the ARM part, with the
above fixed:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
