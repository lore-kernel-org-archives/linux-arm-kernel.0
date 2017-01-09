From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 9 Jan 2017 14:00:07 +0530
Subject: [RFC3 nowrap: PATCH v7 00/18] ILP32 for ARM64
In-Reply-To: <20170106144704.GD12863@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161218070823.GA1153@yury-N73SV>
 <20170106144704.GD12863@e104818-lin.cambridge.arm.com>
Message-ID: <20170109083007.GA6850@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 02:47:04PM +0000, Catalin Marinas wrote:
> On Sun, Dec 18, 2016 at 12:38:23PM +0530, Yury Norov wrote:
> > On Fri, Oct 21, 2016 at 11:32:59PM +0300, Yury Norov wrote:
> > > This series enables aarch64 with ilp32 mode, and as supporting work,
> > > introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> > > existing 32-bit architectures but disabled for new arches (so 64-bit
> > > off_t is is used by new userspace).
> > > 
> > > This version is based on kernel v4.9-rc1.  It works with glibc-2.24,
> > > and tested with LTP.
> >  
> > Hi Arnd, Catalin
> > 
> > For last few days I'm trying to rebase this series on current master,
> > and I see significant conflicts and regressions. In fact, every time
> > I rebase on next rc1, I feel like I play a roulette.
> > 
> > This is not a significant problem now because it's almost for sure
> > that this series will not get into 4.10, for reasons not related to
> > kernel code. And I have time to deal with regressions. But in general,
> > I'd like to try my patches on top of other candidates for next merge
> > window. I cannot read all emails in LKML, but I can easily detect
> > problems and join to the discussion at early stage if I see any problem.
> > 
> > This is probably a noob question, and there are well-known branches,
> > like Andrew Morton's one. But at this stage it's very important to
> > have this series prepared for merge, and I'd prefer to ask about it.
> 
> I'm not entirely sure what the question is. For development, you could
> base your series on a final release, e.g. 4.9. For reviews and
> especially if you are targeting a certain merging window, it's useful to
> rebase your patches on a fairly recent -rc, e.g. 4.10-rc3. I would
> entirely skip any non-tagged kernel states (like middle of the merging
> window) or out of tree branches. There may be a case to rebase on some
> other developer's branch but only if there is a dependency that can't be
> avoided and usually with prior agreement from both the respective
> developer (as not to rebase the branch) and the involved maintainers.

Hi Catalin, 4.10-rcX is good enough but I also need to be sure that
when merge window will be opened I will not find my series broken due
to conflicts, because merge window is only 2 weeks, and there's no
much time to investigate and fix all bugs properly.

Anyway, linux-next is what I need, as Chris mentioned.

Yury
