From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 10 Jun 2010 21:36:39 +0100
Subject: Context Switching is Broken
In-Reply-To: <20100610142015.GC32362@n2100.arm.linux.org.uk>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/10/10, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jun 10, 2010 at 03:16:49PM +0100, Will Deacon wrote:
>  > > On Thu, Jun 10, 2010 at 04:11:35AM -0700, Herman Swartz wrote:
>  > > > Context switching is broken. The man page for context is example code
>  > > > that doesn't work, but should. Does a bug report need to be submitted?
>  > >
>  > > $ man context
>  > > No manual entry for context
>  > >
>
> > Quite. man makecontext has a fairly scary example, maybe that's it.
>
> In which case it's a question for libc people - the kernel has nothing
>  to do with makecontext, getcontext, setcontext and swapcontext.
>
>  I believe for glibc, these are simply unimplemented on ARM, and linking
>  a program which uses makecontext with glibc would result in the linker
>  issuing:
>
>  warning: makecontext is not implemented and will always fail

Indeed on ARM:

martin:~$ make makecontext
cc     makecontext.c   -o makecontext
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

    M
