From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jun 2010 00:36:17 +0100
Subject: Context Switching is Broken
In-Reply-To: <938111.34490.qm@web51801.mail.re2.yahoo.com>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
	<AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
	<148780.29764.qm@web51806.mail.re2.yahoo.com>
	<AANLkTilfwCVpr7JrLlWLIXV1DtAGZyRpvDd_8W-qfq5t@mail.gmail.com>
	<20100610225930.GD32362@n2100.arm.linux.org.uk>
	<938111.34490.qm@web51801.mail.re2.yahoo.com>
Message-ID: <20100610233617.GA9865@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 04:26:47PM -0700, Herman Swartz wrote:
> Yes, the kernel has the functions, because the kernel uses them in
> it's operation. The glibc needs to implement these calls to the
> kernel. Do I have that right?

No.  The kernel's context switching is entirely different to the
"context switching" that you're talking about here.

As I've said twice - and I'm not going to repeat it a third time -
this has nothing to do with the kernel and everything to do with
glibc.

You can see this from the i386 version of setcontext(), which can
be found in the glibc source code:

	sysdeps/unix/sysv/linux/i386/setcontext.S

The only call this code makes to the kernel is to set the processes
signal mask - which ARM has provided since day 1, and is used for
many things other than providing this support.  So there's nothing
to add to the kernel.

What's missing is the glibc support code.  Not the kernel code.

You need to talk to glibc people about this, not kernel people.
