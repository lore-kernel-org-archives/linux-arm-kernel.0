From: rabin@rab.in (Rabin Vincent)
Date: Thu, 1 Apr 2010 00:15:50 +0530
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <1268585771.13400.5.camel@localhost>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
	<1268585771.13400.5.camel@localhost>
Message-ID: <20100331184549.GA20223@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 14, 2010 at 12:56:11PM -0400, Steven Rostedt wrote:
> On Sat, 2010-03-13 at 12:19 +0530, Rabin Vincent wrote:
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 0b94d2f..2535c11 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -209,7 +209,8 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
> >  cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> >  	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
> >  	"$(if $(CONFIG_64BIT),64,32)" \
> > -	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> > +	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
> > +	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> 
> Again, I'll have to test this on other archs, just to make sure its does
> not cause any side effects. Oh, I forgot I now have a MIPS board I can
> test on too. I'll probably do this on Monday.

I've now built PowerPC, SH, and MIPS kernels with dynamic ftrace enabled
and checked that the obj files don't change as the result of this
series.  I've run the MIPS kernel on QEMU and x86_64 on my PC.

Rabin
