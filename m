From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Mar 2010 10:04:14 +0000
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <alpine.LFD.2.00.1003221628290.31128@xanadu.home>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
	<1264437609.6275.110.camel@pc1117.cambridge.arm.com>
	<1269281511.31379.53.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003221457040.31128@xanadu.home>
	<1269288091.31379.57.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003221628290.31128@xanadu.home>
Message-ID: <1269338654.29545.26.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-22 at 20:32 +0000, Nicolas Pitre wrote:
> On Mon, 22 Mar 2010, Daniel Walker wrote:
> 
> > On Mon, 2010-03-22 at 14:58 -0400, Nicolas Pitre wrote:
> > > On Mon, 22 Mar 2010, Daniel Walker wrote:
> > >
> > > > On Mon, 2010-01-25 at 16:40 +0000, Catalin Marinas wrote:
> > > > > Hi Daniel,
> > > > >
> > > > > On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> > > > > > Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> > > > > > kernel hooks to handle domain changes, permission faults, and context
> > > > > > switches.
> > > > >
> > > > > In case you were not aware, there's a patch around (I think since 2007)
> > > > > that removes the domain switching entirely from the kernel (given that
> > > > > they have been deprecated for some time and may disappear completely in
> > > > > the future):
> > > > >
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html
> > > > >
> > > >
> > > > I didn't find this in 2.6.34 ? Are you re-writing it? Why has it been
> > > > around so long out of mainline?
> > >
> > > Because no real hardware out there needed it until recently, i.e.
> > > inertia.
> >
> > Current MSM hardware needs it, just to cover up a defect in the
> > processor. At least that's what this thread was originally about.
> 
> Some other processors should need it too for some architecturally
> defined reasons. Would be a good thing if you could remove your
> emulation and replace it with this patch, and confirm it works for you
> by providing Tested-by tags.

I posted an up-to-date patch yesterday or you can grab it from my devel
branch -
http://www.linux-arm.org/git?p=linux-2.6.git;a=shortlog;h=refs/heads/devel 

(the master branch on his tree is the same, only that it's
merge-friendly rather than rebased but the git server got a bit slower I
think because git gc stopped few some months ago).

-- 
Catalin
