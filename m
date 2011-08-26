From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 26 Aug 2011 15:21:14 +0300
Subject: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
In-Reply-To: <20110826112531.GQ1923@amd.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
	<20110826112531.GQ1923@amd.com>
Message-ID: <CAK=WgbbvOf-3C8HtoZwV9nDomjPHVsEr+ztcMxf4tV=4KDXZ7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 2:25 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Applied all to arm/omap, thanks Ohad. I also put a commit on-top which
> finished the mutex->spin_lock conversion. Looks like one call-place was
> missed. See attached patch.
>
> commit 4234541f1a64d9dc6d489cf8f614dc01c62360f6
> Author: Joerg Roedel <joerg.roedel@amd.com>
> Date: ? Fri Aug 26 13:20:06 2011 +0200
>
> ? ?omap: iommu: Fix up mutex->spin_lock conversion of iommu_lock
>
> ? ?The omap_iommu_set_isr() was still using the mutex functions

Thanks, Joerg.

(I am already working on removing omap_iommu_set_isr() and providing
that functionality via the IOMMU API, so the s/mutex/spinlock/ patch I
squashed with the original patch set accidentally didn't cover that
function).
