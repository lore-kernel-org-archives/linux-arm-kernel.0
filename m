From: davidb@codeaurora.org (David Brown)
Date: Thu, 24 Feb 2011 16:12:06 -0800
Subject: [PATCH 1/3] msm: iommu: Create a Kconfig item for the IOMMU driver
In-Reply-To: <1297799373.7088.5.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Tue, 15 Feb 2011 11:49:33 -0800")
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456729.4852.9.camel@m0nster> <8yar5b9850l.fsf@huya.qualcomm.com>
	<1297799373.7088.5.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8yay655c6qx.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15 2011, Daniel Walker wrote:

> Typically we include everything the SoC has regardless of if drivers use
> the hardware or not . For instance there could be modules that use the
> hardware ..
>
> Regardless of this point, I've nacked the whole series. It looks like
> there was very little thought put into this.

I want to try to resolve this particular series.  I had originally
pulled the series in because I thought everything had been addressed,
you followed this with a generic NAK.

You raised a couple of issues:

  - Should this be configurable?  I responded that our iommu is
    optional.  Drivers will work whether the iommu is enabled or not.
    Other architectures have configurable iommu drivers (and some are
    selected).  For example: arm/plat-s5p, powerpc/pasemi, as well x86.

    One reason to disable may be for building a slimmed kernel for
    kexec.

  - Should the iommu driver be under arch/arm/mach-msm.  As discussed in
    <https://lkml.org/lkml/2011/2/22/722>, iommu drivers fall into kind
    of a grey area.  Currently, most platform iommu drivers are in arch
    specific directories.

  - The renaming of the device file.  At this point, the two MSM chips
    that have an IOMMU have an identical IOMMU configuration.  The
    patches reflect this by removing the soc name from the file.  Future
    chips will probably have iommu hardware that differs, but it isn't
    possible to predict what the differences will be, so that will have
    to be addressed then.

I can certainly back out the changes if necessary.  Please let me know
if you have any specific concerns.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
