From: w@1wt.eu (Willy Tarreau)
Date: Sun, 23 Jun 2013 09:20:58 +0200
Subject: [PATCH v7] ARM PJ4B: Add support for errata 4742
In-Reply-To: <20130622155103.GA11542@1wt.eu>
References: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
 <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
 <20130622154421.GA475@localhost> <20130622155103.GA11542@1wt.eu>
Message-ID: <20130623072058.GD11542@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 05:51:03PM +0200, Willy Tarreau wrote:
> On Sat, Jun 22, 2013 at 12:44:22PM -0300, Ezequiel Garcia wrote:
> > Hi Greg,
> > 
> > On Fri, Jun 21, 2013 at 05:31:04PM +0200, Gregory CLEMENT wrote:
> > > This commit fixes the regression on Armada 370 (the kernal hang during
> > > boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> > > TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> > > 
> > > When coming out of either a Wait for Interrupt (WFI) or a Wait for
> > > Event (WFE) IDLE states, a specific timing sensitivity exists between
> > > the retiring WFI/WFE instructions and the newly issued subsequent
> > > instructions. This sensitivity can result in a CPU hang scenario.  The
> > > workaround is to insert either a Data Synchronization Barrier (DSB) or
> > > Data Memory Barrier (DMB) command immediately after the WFI/WFE
> > > instruction.
> > > 
> > > This commit was based on the work of Lior Amsalem, but heavily
> > > modified to apply the errata fix dynamically according to the
> > > processor type thanks to the suggestions of Russell King and Nicolas
> > > Pitre.
> > >
> > > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > > Cc: <stable@vger.kernel.org>
> > 
> > This patch doesn't seem to apply on any 3.10-rcX;
> > maybe I'm doing something wrong, but could you double-check this?
> 
> Interesting, I had the same issue and thought it was because of my
> tree, though visually I couldn't spot the issue. It probably was a
> space/tab issue only.

OK it was probably because of other pending changes since rc6, because
it applied perfectly on top of 3.10-rc7.

Willy
