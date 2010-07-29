From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 29 Jul 2010 11:25:04 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729181412H.fujita.tomonori@lab.ntt.co.jp>
References: <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<20100729181412H.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100729092503.GO26098@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 05:14:49AM -0400, FUJITA Tomonori wrote:
> On Thu, 29 Jul 2010 11:06:08 +0200
> "Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:
> > I have no clue about the ARM iommus on the omap-platform. From a quick
> > look into the header file I see some similarities to the IOMMU-API. I am
> 
> ARM's iommu stuff might be more appropriate as the IOMMU-API than
> include/linux/iommu.h

Then lets add this functionality to the generic IOMMU-API.

> > also very open for discussions about how the IOMMU-API could be extended
> > to fit the needs of other platforms. Only because nobody has tried to
> > discuss about such an effort is no reason to push the IOMMU-API back.
> 
> Well, the reason (nobody has tried) might be that linux/iommu.h
> doesn't look something intended for the generic IOMMU-API.

How does it not look like a generic intention? The function names are
all generic and do not express that this API should only be used for
KVM. If you talk about the design of the API itself, it was designed for
the IOMMUs I was aware of at the time writing the API (in fact, the
initial design was not my own, it was a generalization of the VT-d
interfaces for KVM).
In other words it was a bottom-up approach to fit the needs of the time
it was written. But its an kernel-only API so we can easily change it
and extend it for other users/iommus when the need arises. I think this
is the way we should go instead of letting each architecture design
their own IOMMU-interfaces.

		Joerg

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
