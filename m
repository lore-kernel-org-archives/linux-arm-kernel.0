From: eparis@redhat.com (Eric Paris)
Date: Tue, 21 Feb 2012 08:35:50 -0500
Subject: [PATCH - linux-next] ARM: ptrace: Fix audit caused compile error
In-Reply-To: <20120221133044.GN22562@n2100.arm.linux.org.uk>
References: <1329825855-11902-1-git-send-email-peter.ujfalusi@ti.com>
 <20120221131616.GI19696@mudshark.cambridge.arm.com>
 <20120221133044.GN22562@n2100.arm.linux.org.uk>
Message-ID: <1329831350.2337.43.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-21 at 13:30 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2012 at 01:16:17PM +0000, Will Deacon wrote:
> > On Tue, Feb 21, 2012 at 12:04:15PM +0000, Peter Ujfalusi wrote:
> > > While trying to compile the kernel for ARM (omap2plus_defconfig) the kernel
> > > build fails with:
> > > 
> > > arch/arm/kernel/ptrace.c: In function ?syscall_trace?:
> > > arch/arm/kernel/ptrace.c:920:3: error: implicit declaration of function ?audit_syscall_exit?
> > > arch/arm/kernel/ptrace.c:922:3: error: implicit declaration of function ?audit_syscall_entry?
> > > arch/arm/kernel/ptrace.c:922:23: error: ?AUDIT_ARCH_ARMEB? undeclared (first use in this function)
> > > arch/arm/kernel/ptrace.c:922:23: note: each undeclared identifier is reported only once for each function it appears in
> > > make[1]: *** [arch/arm/kernel/ptrace.o] Error 1
> > > 
> > > The issue created by commit:
> > > 29ef73b7 Kernel: Audit Support For The ARM Platform
> > > 
> > > We need to include the linux/audit.h header to the arch/arm/kernel/ptrace.c
> > > file to be able to compile the kernel.
> > 
> > This was already reported and I think Russell was going to revert the
> > offending commit, since it needed some rework to handle little-endian
> > configurations.
> > 
> > I can't see the revert in any of the trees I'm tracking though...
> 
> I never pushed that out because I thought someone was going to fix it.
> Were any patches produced to fix it?  I can't see anything in the patch
> system and I couldn't see anything on the list.
> 
> It seems the previous thread about it just died.  Oh well, I guess a
> revert is what's required after all.

http://marc.info/?l=linux-arm-kernel&m=132928424120369&w=2

???
