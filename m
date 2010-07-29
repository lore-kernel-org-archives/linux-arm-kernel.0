From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 29 Jul 2010 12:01:09 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729184336N.fujita.tomonori@lab.ntt.co.jp>
References: <20100729090607.GN26098@amd.com>
	<20100729181412H.fujita.tomonori@lab.ntt.co.jp>
	<20100729092821.GP26098@amd.com>
	<20100729184336N.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100729100108.GQ26098@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 05:44:13AM -0400, FUJITA Tomonori wrote:
> On Thu, 29 Jul 2010 11:28:21 +0200
> "Roedel, Joerg" <Joerg.Roedel@amd.com> wrote:
> 
> > On Thu, Jul 29, 2010 at 05:14:49AM -0400, FUJITA Tomonori wrote:
> > > Well, the reason (nobody has tried) might be that linux/iommu.h
> > > doesn't look something intended for the generic IOMMU-API.
> > 
> > Oh, and as an additional note, the reason might also be that people were
> > not aware of its existence :-)
> 
> No. People actually read it and think that it's not intended for
> generic purposes, i.e., it was designed for VT-d/AMD-IOMMU with KVM:
> 
> http://lkml.org/lkml/2010/7/28/470

This states the as-is situation. There is not a single sentence that
states why the iommu-api can't be extended to fit their needs. Nobody
has ever written me an email about this to discuss this possibility.

> You designed it for what you need at the time. It should have been
> named appropriately to avoid confusion. Later, when we actually
> understand what other IOMMUs need, we can evolve the specific API for
> generic purposes. Then we can rename the API to more generic.

At the time the iommu-api was written is was generic enough for what we
had. So it was designed as an generic API. At this point in time nobody
knew what the future requirements would we. So today it turns out that
it is not generic enough anymore for latest hardware. The logical
consequence is to fix this in the iommu-api.

		Joerg

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
