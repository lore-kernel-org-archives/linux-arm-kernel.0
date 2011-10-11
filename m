From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 11 Oct 2011 19:01:23 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <20111011103820.GF2138@amd.com>
References: <20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
	<20111011103820.GF2138@amd.com>
Message-ID: <CAK=WgbYOUZNX0OmRwZNO1mMG+3DZXwff+S60ESWixf04HOcbtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 12:38 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> You need to make sure that you don;t pass larger regions then requested
> to the low-level driver. Some logic like in the iommu_map function
> should do it.

You're right. But the solution IMHO should be getting rid of that size
-> order -> size conversion which we do back and forth, as it's kinda
pointless.

> Please use PAGE_SIZE instead of 0x1000UL.

This one would go away too if we remove the size -> order -> size
conversions. In fact, iommu_unmap() just becomes so much simpler when
we do that.

I'm attaching two patches: first one that removes the
size->order->size conversions we have, and then the usual pgsize patch
rebased to it.

Please take a look,

Thanks,
Ohad.
