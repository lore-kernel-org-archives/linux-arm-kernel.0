From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 6 Mar 2017 18:00:03 +0900
Subject: [PATCH/RFC v2 0/4] iommu/ipmmu-vmsa: IPMMU slave device whitelist
 V2
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Message-ID: <CANqRtoQR3S=MbVE91s5Ku=XZZ6XxpPFUfZ0FYFxiEcqts5N-pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 3:14 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> iommu/ipmmu-vmsa: IPMMU slave device whitelist V2
>
> [PATCH/RFC v2 1/4] iommu/of: Skip IOMMU devices disabled in DT
> [PATCH/RFC v2 2/4] iommu/ipmmu-vmsa: Get rid of disabled device check
> [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Check devices in xlate()
> [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Opt-in slave devices based on ES version
>
> Here's an updated prototype that shows how DT integration of IPMMU details
> may be integrated and merged upstream based on SoC data sheet ahead of
> time followed by enablement in the IPMMU driver code once the appropriate
> SoC ES version has been released and the hardware has been tested.
>
> Changes since V1:
>  - Broke out patch 1 from the IPMMU driver
>  - Moved slave device check from ->add_device() to ->xlate() (Thanks Robin!)
>  - Updated white list patch to hook into ->xlate()
>
> Patch 1 may be suitable for upstream merge, however other patches should
> in the future if agreed on be rolled into the IPMMU driver series.

Hi Geert, everyone,

Do you have any opinion about the code in this version of the series?

I recall that you agreed with the approach in "[PATCH/RFC 2/2]
iommu/ipmmu-vmsa: Opt-in slave devices based on ES version", however
it was suggested to me by Robin that my code in "[PATCH/RFC 1/2]
arm64: mm: Silently allow devices lacking IOMMU group" should be
reworked to use ->xlate().

Now this series makes use of ->xlate() to implement the white list, so
I hope that makes everyone happy.

Also, based on your suggestion I finally managed to break out the code
that skips over disabled devices in "[PATCH/RFC v2 1/4] iommu/of: Skip
IOMMU devices disabled in DT" but I'm not sure if this will cause
problem for other platforms.

Anyway, my current plan is to wait for feedback for "[PATCH/RFC v2
1/4] iommu/of: Skip IOMMU devices disabled in DT" and handle that
independently, and also roll in the other changes in this series into
my other IPMMU code.

Thanks,

/ magnus
