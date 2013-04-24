From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Apr 2013 12:10:02 +0100
Subject: [PATCH v3 08/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <5177BBEE.1090209@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-9-git-send-email-marc.zyngier@arm.com>
 <20130423225816.GC20569@gmail.com> <5177BBEE.1090209@arm.com>
Message-ID: <20130424111002.GJ21850@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:03:10PM +0100, Marc Zyngier wrote:
> On 23/04/13 23:58, Christoffer Dall wrote:
> > I noticed that this doesn't do any cache cleaning.  Are the MMU page
> > table walks guaranteed to be coherent with the MMU on arm64?
> 
> I suppose you meant the cache. In this case, yes. The hardware page
> table walker must snoop the caches.

Also, for ARMv7, SMP implies that the hardware walker snoops the cache. I
recently upstreamed some patches for this (see "ARM: 7691/1: mm: kill unused
TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead" in -next), so you might
want to check if there are any remaining, redundant flushes in kvm for ARMv7.

Will
