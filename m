From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 29 Jul 2010 18:44:13 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729092821.GP26098@amd.com>
References: <20100729090607.GN26098@amd.com>
	<20100729181412H.fujita.tomonori@lab.ntt.co.jp>
	<20100729092821.GP26098@amd.com>
Message-ID: <20100729184336N.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Jul 2010 11:28:21 +0200
"Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:

> On Thu, Jul 29, 2010 at 05:14:49AM -0400, FUJITA Tomonori wrote:
> > Well, the reason (nobody has tried) might be that linux/iommu.h
> > doesn't look something intended for the generic IOMMU-API.
> 
> Oh, and as an additional note, the reason might also be that people were
> not aware of its existence :-)

No. People actually read it and think that it's not intended for
generic purposes, i.e., it was designed for VT-d/AMD-IOMMU with KVM:

http://lkml.org/lkml/2010/7/28/470

You designed it for what you need at the time. It should have been
named appropriately to avoid confusion. Later, when we actually
understand what other IOMMUs need, we can evolve the specific API for
generic purposes. Then we can rename the API to more generic.
