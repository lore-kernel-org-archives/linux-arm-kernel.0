From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 May 2015 14:25:57 +0100
Subject: [PATCH tip/core/rcu 7/9] arm64: Use common
 outgoing-CPU-notification code
In-Reply-To: <20150521124833.GJ6776@linux.vnet.ibm.com>
References: <20150512214945.GA813@linux.vnet.ibm.com>
 <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1431467407-1223-7-git-send-email-paulmck@linux.vnet.ibm.com>
 <20150521085806.GC21920@arm.com>
 <20150521124833.GJ6776@linux.vnet.ibm.com>
Message-ID: <20150521132557.GK29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 05:48:33AM -0700, Paul E. McKenney wrote:
> On Thu, May 21, 2015 at 09:58:06AM +0100, Will Deacon wrote:
> > On Tue, May 12, 2015 at 10:50:05PM +0100, Paul E. McKenney wrote:
> > > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > > 
> > > This commit removes the open-coded CPU-offline notification with new
> > > common code.  In particular, this change avoids calling scheduler code
> > > using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> > > change.  A more intrusive change might invoke the cpu_check_up_prepare()
> > > and cpu_set_state_online() functions at CPU-online time, which would
> > > allow onlining throw an error if the CPU did not go offline properly.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/kernel/smp.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > I don't have a better idea, so:
> > 
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Is this queued via -tip already, or can we pick it into the arm64 tree
> > for 4.2?
> 
> Feel free to take it into the arm64 tree.  Just let me know, and I
> will drop it from my tree.

Queued for 4.2. Thanks.

-- 
Catalin
