From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 09:27:28 +0000
Subject: [PATCH 1/1] ARM: cns3xxx: Fixup the missing second parameter
	to addruart macro to allow them to build.
In-Reply-To: <20101115090146.GB8942@pengutronix.de>
References: <1289772114-7343-1-git-send-email-mkl0301@gmail.com>
	<20101115090146.GB8942@pengutronix.de>
Message-ID: <20101115092728.GB24194@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:01:46AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Nov 15, 2010 at 06:01:54AM +0800, mkl0301 at gmail.com wrote:
> > From: Mac Lin <mkl0301@gmail.com>
> > 
> > Fixup the missing second parameter to addruart macro to allow them to build,
> > according to to commit 0e17226f7cd289504724466f4298abc9bdfca3fe.
> > 
> > Enabling DEBUG in head.S would cause:
> > rch/arm/boot/compressed/head.S: Assembler messages:
> > arch/arm/boot/compressed/head.S:1037: Error: too many positional arguments
> > arch/arm/boot/compressed/head.S:1055: Error: too many positional arguments
> > 
> > Signed-off-by: Mac Lin <mkl0301@gmail.com>
> > ---
> >  arch/arm/mach-cns3xxx/include/mach/debug-macro.S |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
> > index d16ce7e..9b50442 100644
> > --- a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-cns3xxx/include/mach/debug-macro.S
> > @@ -10,7 +10,7 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > -		.macro	addruart,rx
> > +		.macro	addruart,rx,rtmp
> >  		mrc	p15, 0, \rx, c1, c0
> >  		tst	\rx, #1			@ MMU enabled?
> >  		moveq	\rx,      #0x10000000
> This doesn't apply to current Russell's (or Linus') tree.  (And is wrong
> there BTW.)  Which version does your patch apply to?

Uwe,

I know you're trying to help by acking all patches you can find, but
you need to think a little deeper first, otherwise you're going to
create confusion.  This is the second instance this morning...

For instance, with this patch it isn't applicable to the current -rc -
which builds fine.  This patch is addressing an issue on 2.6.35 and
2.6.36 kernels, and applies fine there.  I've already forwarded this
to the stable kernel maintainers, along with a note explaining why
the usual rule of "get it into Linus' tree first" can't apply.
