From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 23 Feb 2010 13:37:44 -0500
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <20100223182338.GC5836@debian>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-8-git-send-email-rabin@rab.in>
	<1266931846.19540.9.camel@frodo>  <20100223182338.GC5836@debian>
Message-ID: <1266950264.24271.6116.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-02-23 at 23:53 +0530, Rabin Vincent wrote:

> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 0b94d2f..2535c11 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -209,7 +209,8 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
> > >  cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> > >  	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
> > >  	"$(if $(CONFIG_64BIT),64,32)" \
> > > -	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> > > +	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
> > > +	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> > 
> > Doesn't this need to be with the change of recordmcount.pl too?
> > Otherwise applying this patch alone will break it. We need every step of
> > the patches to work otherwise we risk breaking a kernel bisect.
> 
> Dynamic ftrace for ARM is only enabled in the last patch of the series,
> so this woudn't be breaking it.  No modification should be required for
> record_mcount.pl for other archs because this doesn't add/remove any
> parameters.

OK, it looked to me that "KBUILD_CFLAGS" was a separate parameter. I
miscounted my quotes. ;-)

-- Steve
