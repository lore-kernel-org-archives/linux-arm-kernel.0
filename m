From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 29 Jul 2011 13:30:20 +0200
Subject: Question about "Inconsistent kallsyms data"
In-Reply-To: <2563791.8cBqodrk1o@flatron>
References: <02ae01cc4d91$aed71670$0c854350$%kim@samsung.com>
	<20110729100241.GB25640@n2100.arm.linux.org.uk>
	<2563791.8cBqodrk1o@flatron>
Message-ID: <1514384.7oMe1aulyC@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 of July 2011 at 12:58:32, Tomasz Figa wrote:
> On Friday 29 of July 2011 at 11:02:41, Russell King - ARM Linux wrote:
> > On Fri, Jul 29, 2011 at 12:00:07PM +0200, Tomasz Figa wrote:
> > > Hi,
> > > 
> > > On Friday 29 of July 2011 at 10:48:46, Kukjin Kim wrote:
> > > > Hi all,
> > > > 
> > > > When build with s5pc100_defconfig, happens following.
> > > > 
> > > > ...
> > > > KSYM    .tmp_kallsyms2.S
> > > > AS      .tmp_kallsyms2.o
> > > > LD      vmlinux
> > > > SYSMAP  System.map
> > > > SYSMAP  .tmp_System.map
> > > > Inconsistent kallsyms data
> > > > This is a bug - please report about it
> > > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > > > make[1]: *** [vmlinux] Error 1
> > > > make: *** [sub-make] Error 2
> > > > 
> > > > Its HEAD is following (current latest mainline)
> > > > (commit 55f9c40ff632d03c527d6a6ceddcda0a224587a6)
> > > > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
> > > 
> > > I can confirm that it also happens when building with
> > > s3c6400_defconfig
> > > and HEAD at commit 5fd00b031530cc476240f654c078c930f1dcd6ea (Merge
> > > branch 'for- linus' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6).
> > > 
> > > The suggested workaround (make KALLSYMS_EXTRA_PASS=1) helps, but it
> > > is
> > > only a workaround and not a solution.
> > > 
> > > Any suggestions?
> > 
> > Someone want to try bisecting to find the commit?
> 
> I will try to bisect the case with s3c6400 defconfig.

I have no idea why, but I cannot reproduce the issue anymore, even after make 
distclean or starting with a clean tree. A build system bug?

I do not know much technical details about the kernel build system, but might 
it be a concurrency issue (I use make -j5 for building with 5 jobs)?
