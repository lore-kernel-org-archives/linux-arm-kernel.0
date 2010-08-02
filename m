From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 2 Aug 2010 09:48:12 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <1280546124.1902.30.camel@pasglop>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de>
	<1280546124.1902.30.camel@pasglop>
Message-ID: <20100802074812.GM24084@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 11:15:24PM -0400, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-29 at 10:26 +0200, Arnd Bergmann wrote:
> > Exactly, thanks for the clarification. I also didn't realize that
> > there
> > is now an include/linux/iommu.h file that only describes the PCI
> > SR-IOV
> > interfaces, unlike the generic IOMMU support that we have in your
> > include/linux/dma-mapping.h file.
> > 
> > Maybe we should rename linux/iommu.h to something more specific so we
> > can reduce this confusion in the future.
> 
> Hrm, indeed I just noticed that. Pretty gross... it should definitly be
> renamed, is will caused endless confusion with unrelated iommu.h and
> iommu_* interfaces which represent something different.

The first direction to go should be trying to unify all the different
iommu* interfaces into the iommu-api. The generic api will definitly
need to be extended for that, but since it is an in-kernel interface
thats no problem.

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
