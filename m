From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Sep 2011 08:15:54 +0100
Subject: [PATCH 6/6] ARM: zImage: prevent constant copy+rebuild of
	lib1funcs.S
In-Reply-To: <4E72C96F.5000203@codeaurora.org>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-7-git-send-email-nico@fluxnic.net>
	<4E72C96F.5000203@codeaurora.org>
Message-ID: <20110916071554.GB22533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 08:58:39PM -0700, Stephen Boyd wrote:
> On 09/13/11 22:41, Nicolas Pitre wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> >
> > The rule to copy this file doesn't have to be forced.  However
> > lib1funcs.[So] have to be listed amongst the targets.
> >
> > This prevents zImage from being recreated needlessly.
> >
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> >  arch/arm/boot/compressed/Makefile |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index ce2bef536e..db1fd260ed 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -112,7 +112,7 @@ endif
> >  
> >  targets       := vmlinux vmlinux.lds \
> >  		 piggy.$(suffix_y) piggy.$(suffix_y).o \
> > -		 font.o font.c head.o misc.o $(OBJS)
> > +		 lib1funcs.o lib1funcs.S font.o font.c head.o misc.o $(OBJS)
> >  
> >  # Make sure files are removed during clean
> >  extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S $(libfdt) $(libfdt_hdrs)
> > @@ -147,7 +147,7 @@ LDFLAGS_vmlinux += -T
> >  # For __aeabi_uidivmod
> >  lib1funcs = $(obj)/lib1funcs.o
> >  
> > -$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
> > +$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
> >  	$(call cmd,shipped)
> >  
> >  # We need to prevent any GOTOFF relocs being used with references
> 
> I already posted a very similar patch and put it into Russell's patch
> tracker. Can't you just use that instead?

You did, but then there followed quite a lengthy discussion about it
so I avoided applying it.  The discussion didn't seem to really reach
any conclusion wrt the patch so I didn't know what to do about it.
