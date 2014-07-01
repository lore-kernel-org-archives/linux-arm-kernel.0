From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 15:14:01 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <CALCETrV=m1v=YuAYVBdRroGWY+nYEfWQbFYKD+su-n_xDBeGKg@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <53B2BF2A.4070407@mentor.com>
 <CALCETrV=m1v=YuAYVBdRroGWY+nYEfWQbFYKD+su-n_xDBeGKg@mail.gmail.com>
Message-ID: <20140701141401.GR32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 07:09:46AM -0700, Andy Lutomirski wrote:
> On Tue, Jul 1, 2014 at 7:01 AM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> > Hmm, which tools?  Shouldn't they be consulting AT_SYSINFO_EHDR in the
> > auxiliary vector instead?
> >
> 
> There were a bunch of random things written before getauxvec(3) was
> introduced that look for "[vdso]"
> 
> gdb is also a bit weird.  I think it's changed a couple times, but
> IIRC it looks for a vma that has a start address that matches
> AT_SYSINFO_EDHR, and then it parses the ELF header and *section*
> headers (sigh) in that vma.  So if I'm remembering correctly, it just
> won't notice the vdso at all of AT_SYSINFO_EHDR and the vma start
> aren't the same.

Hmm, that would explain the weird error I got when trying gdb with the
vdso in place.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
