From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 12:49:10 -0500
Subject: [PATCH] ARM: multi_v7: add mvebu and drivers to defconfig
In-Reply-To: <CAGa+x86rOYy8CcYr2eVfwvBta4CJN+_mrWFyft=0Hus_E=DXjA@mail.gmail.com>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
 <8761p4w2yu.fsf@paris.lan> <52E7CF49.8040703@free-electrons.com>
 <CAGa+x86rOYy8CcYr2eVfwvBta4CJN+_mrWFyft=0Hus_E=DXjA@mail.gmail.com>
Message-ID: <20140128174910.GU29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 07:59:47AM -0800, Kevin Hilman wrote:
> On Tue, Jan 28, 2014 at 7:39 AM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
> > On 28/01/2014 16:17, Kevin Hilman wrote:
> >> Jason Cooper <jason@lakedaemon.net> writes:
> >>
> >>> boot farms testing is highlighting some errors in mvebu.  Let's get some
> >>> more coverage for multi_v7_defconfig kernels.
> >>>
> >>> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> >>> ---
> >>> Kevin,
> >>>
> >>> This is against tonight's master.  Feel free to take it directly.
> >>>
> >>
> >> OK, but this one doesn't currently fix any known errors, right?  (the
> >> pull request you sent yesterday fixes the boot regressions, IIUC.)  The
> >> goal here is just to get more mvebu coverage in multi_v7_defconfig,
> >> correct?
> >>
> >> That being said, have a closer look at the Kconfig entries that are
> >> removed by the patch below, many of which will have an impact on other
> >> platforms.
> >
> > Hi Kevin,
> >
> > I may be wrong but I suspect this config file was generated with make savedefconfig.
> > this rule only generate the CONFIG that are not implied by other CONFIG,
> > so I wonder if all this changes are just due to of modificatino in the Kconfig
> > themselves.
> 
> Yes, I suspect that as well, which means the changelog needs to have a
> bit more detail justifying those removals that look suspicious when
> just looking through the diff.

Agreed.  I was debating doing two patches, but thought it would be
overkill.  I'll resend a v2 as two patches.  I'm also going to put it on
mvebu/defconfig branch so that I can also build and test against it
throughout the merge window.

thx,

Jason.
