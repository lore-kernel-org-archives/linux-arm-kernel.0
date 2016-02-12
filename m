From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Feb 2016 15:52:22 +0000
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <alpine.LFD.2.20.1602121106140.1773@schleppi>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad> <20160212100137.GE25087@arm.com>
 <alpine.LFD.2.20.1602121106140.1773@schleppi>
Message-ID: <20160212155221.GP25087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 11:12:34AM +0100, Sebastian Ott wrote:
> On Fri, 12 Feb 2016, Will Deacon wrote:
> > On Thu, Feb 11, 2016 at 08:57:02PM +0100, Gerald Schaefer wrote:
> > > On Thu, 11 Feb 2016 21:09:42 +0200
> > > "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> > > > On Thu, Feb 11, 2016 at 07:22:23PM +0100, Gerald Schaefer wrote:
> > > > > Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
> > > > > he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
> > > > > review of the THP rework patches, which cannot be bisected, revealed
> > > > > commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
> > > > > (and also similar commits for other archs).

[...]

> > Do you have a reliable way to trigger the "random kernel crashes"? We've not
> > seen anything reported on arm64, but I don't see why we wouldn't be affected
> > by the same bug and it would be good to confirm and validate a fix.
> 
> My testcase was compiling the kernel. Most of the time my test system
> didn't survive a single compile run. During bisect I did at least 20
> compile runs to flag a commit as good.

I've been building kernels all day with -rc3 on my arm64 box and haven't
seen any problems yet.. :/.

I'll leave it going over the weekend.

Will
