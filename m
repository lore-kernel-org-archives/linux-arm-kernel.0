From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Aug 2013 10:32:49 +0900
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
In-Reply-To: <51FA5B76.6030107@windriver.com>
References: <20130731055807.14054.70106.sendpatchset@w520>
 <20130731094352.GV24642@n2100.arm.linux.org.uk>
 <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
 <20130731193930.GY24642@n2100.arm.linux.org.uk>
 <20130801073443.GB15265@verge.net.au>
 <51FA5B76.6030107@windriver.com>
Message-ID: <20130802013249.GB30121@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 08:58:30AM -0400, Paul Gortmaker wrote:
> On 13-08-01 03:34 AM, Simon Horman wrote:
> > On Wed, Jul 31, 2013 at 08:39:30PM +0100, Russell King - ARM Linux wrote:
> >> On Thu, Aug 01, 2013 at 04:34:03AM +0900, Magnus Damm wrote:
> >>> Are you aware of any existing fix for this or anyone working on
> >>> solving this issue? If not then I don't mind stepping up. I can
> >>> however think of quite a few other things to do if this has been
> >>> solved already though, so please let me know if you think I should
> >>> focus on fixing this.
> >>
> >> I committed a fix for it this morning, so it should be in linux-next by
> >> tomorrow.
> > 
> > Hi Russell,
> > 
> > Magnus has some outstanding patches for Renesas SoC boards which I believe
> > depend on this problem being resolved.  Could you indicate when you expect
> > this patch to be in a stable branch which I could use as a base for a
> > branch that will subsequently be pulled into arm-soc.
> 
> It will never be in a stable release, since the cpuinit removal was
> added in the 3.11-rc1 merge window content, and the fix will be in
> before 3.11 final hits the streets.  If you want stable stuff, you
> should be using v3.10 at this point in time.

Sorry for my loose use of the word stable.

I meant a branch that will be incorporated into a future mainline release.
>From your response above I assume that I can use v3.11-rcX for some values
of X.

Can I confirm that the commit I should be looking for is
cd717a2a3db96af1e308d5bdb76c9d5f8154b4bd
("ARM: Add .text annotations where required after __CPUINIT removal")?
