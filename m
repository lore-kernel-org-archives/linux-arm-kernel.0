From: herman_swartz@yahoo.com (Herman Swartz)
Date: Thu, 10 Jun 2010 14:18:58 -0700 (PDT)
Subject: Context Switching is Broken
In-Reply-To: <AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
	<AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
Message-ID: <148780.29764.qm@web51806.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin,

Looks like you took the example code out of the man page and tried to compile. This is what I get to. Look at my email sent a few minutes ago.

Thanks
HermanI



----- Original Message ----
From: Martin Guy <martinwguy@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>; Herman Swartz <herman_swartz@yahoo.com>; linux-arm-kernel at lists.infradead.org
Sent: Thu, June 10, 2010 4:36:39 PM
Subject: Re: Context Switching is Broken

On 6/10/10, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jun 10, 2010 at 03:16:49PM +0100, Will Deacon wrote:
>? > > On Thu, Jun 10, 2010 at 04:11:35AM -0700, Herman Swartz wrote:
>? > > > Context switching is broken. The man page for context is example code
>? > > > that doesn't work, but should. Does a bug report need to be submitted?
>? > >
>? > > $ man context
>? > > No manual entry for context
>? > >
>
> > Quite. man makecontext has a fairly scary example, maybe that's it.
>
> In which case it's a question for libc people - the kernel has nothing
>? to do with makecontext, getcontext, setcontext and swapcontext.
>
>? I believe for glibc, these are simply unimplemented on ARM, and linking
>? a program which uses makecontext with glibc would result in the linker
>? issuing:
>
>? warning: makecontext is not implemented and will always fail

Indeed on ARM:

martin:~$ make makecontext
cc? ? makecontext.c? -o makecontext
/tmp/ccnapqW4.o: In function `main':
makecontext.c:(.text+0x110): warning: warning: getcontext is not
implemented and will always fail
makecontext.c:(.text+0x164): warning: warning: makecontext is not
implemented and will always fail
/tmp/ccnapqW4.o: In function `func1':
makecontext.c:(.text+0x24): warning: warning: swapcontext is not
implemented and will always fail
$ ./makecontext
Function not inplemented.
$

so?

? ? M



      
