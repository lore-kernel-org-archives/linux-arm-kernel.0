From: dacohen@gmail.com (David Cohen)
Date: Tue, 15 Feb 2011 15:32:24 +0200
Subject: [PATCH 0/2] IOMMU fault callback support
In-Reply-To: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Message-ID: <AANLkTinPD_iktt22eY4MPc3uG4CKB+c5A5QSYjFLxHfU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A missing prefix in the cover letter's subject. It's: OMAP: IOMMU:

Br,

David

On Tue, Feb 15, 2011 at 3:20 PM, David Cohen <dacohen@gmail.com> wrote:
> Hi,
>
> This patch set adds fault callback support to allow IOMMU users to debug or
> react when a fault happens.
> IOMMU faults might be very difficult to reproduce and then to figure out
> the source of the problem. Currently IOMMU driver prints not so useful
> debug message and does not notice user about such issue.
> With a fault callback, IOMMU user may debug much more useful information
> and/or react to go back to a valid state.
>
> Br,
>
> David
> ---
>
> David Cohen (2):
> ?OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
> ?OMAP: IOMMU: add support to callback during fault handling
>
> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ?| ? 27 ++++++++++++++++----
> ?arch/arm/plat-omap/include/plat/iommu.h | ? 15 ++++++++++-
> ?arch/arm/plat-omap/iommu.c ? ? ? ? ? ? ?| ? 41 ++++++++++++++++++++++++++++---
> ?3 files changed, 72 insertions(+), 11 deletions(-)
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
