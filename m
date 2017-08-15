From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Aug 2017 14:38:41 +0100
Subject: [PATCH 01/11] arm64: numa: Remove the unused parent_node() macro
In-Reply-To: <0e088b13-12eb-3bf6-696d-9fdd79e96670@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1501076076-1974-2-git-send-email-douly.fnst@cn.fujitsu.com>
 <20170804133017.GD15287@arm.com>
 <0e088b13-12eb-3bf6-696d-9fdd79e96670@cn.fujitsu.com>
Message-ID: <20170815133840.f5ykdecovzhiydbh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 11:28:36PM +0800, Dou Liyang wrote:
> Hi will,
> 
> At 08/04/2017 09:30 PM, Will Deacon wrote:
> > On Wed, Jul 26, 2017 at 09:34:26PM +0800, Dou Liyang wrote:
> > > Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> > > __register_one_node()") removes the last user of parent_node().
> > > 
> > > The parent_node() macro in ARM64 platform is unnecessary.
> > > 
> > > Remove it for cleanup.
> > > 
> > > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > > Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > ---
> > >  arch/arm64/include/asm/numa.h | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> > > index bf466d1..ef7b238 100644
> > > --- a/arch/arm64/include/asm/numa.h
> > > +++ b/arch/arm64/include/asm/numa.h
> > > @@ -7,9 +7,6 @@
> > > 
> > >  #define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
> > > 
> > > -/* currently, arm64 implements flat NUMA topology */
> > > -#define parent_node(node)	(node)
> > > -
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Where you intending for this to go via the arm64 tree?
> 
> I intend for this to go to upstream tree. shall we?

Queued for 4.14. Thanks.

-- 
Catalin
