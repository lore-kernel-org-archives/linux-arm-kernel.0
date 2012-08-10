From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 16:20:36 +0100
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <50252525.8050602@free-electrons.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
 <20120808151946.GE4579@mudshark.cambridge.arm.com>
 <50229422.40305@free-electrons.com>
 <50229944.60603@free-electrons.com>
 <20120810144922.GH2066@mudshark.cambridge.arm.com>
 <50252525.8050602@free-electrons.com>
Message-ID: <20120810152036.GK2066@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 04:13:41PM +0100, Gregory CLEMENT wrote:
> On 08/10/2012 04:49 PM, Will Deacon wrote:
> > Can the Armada 370 be configured to use the co-processor interface to the
> > L2, or does only the Armada XP support that feature? What happens if you
> > build a single zImage supporting both of the SoCs?
> 
> About L2 cache we already use the same kernel on Armada 370 and Armada XP
> and the differences are in the device tree.

Right, but I wonder whether you can end up using both the outer_cache
functions *and* the co-processor interface on the Armada XP by accident.
Ideally, we'd just use the co-processor interface on all platforms and
ignore the memory-mapped one. Is that possible on the 370?

> Now if I understood correctly what the LPAE involved, I guess we can't have
> a kernel with LAPE running on Armada 370.

Indeed, but you could still run with 2-level page tables on both SoCs (with
less memory on the XP).

Will
