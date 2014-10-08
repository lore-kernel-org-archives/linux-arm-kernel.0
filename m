From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 8 Oct 2014 14:45:41 -0500
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add SDHC nodes for APQ8084 platform
In-Reply-To: <CAP71WjxYibPGBC=x4eA-Lmjg_Mc7cCB20VSvf59C_AW7PYNE=A@mail.gmail.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
 <1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
 <CAP71WjxYibPGBC=x4eA-Lmjg_Mc7cCB20VSvf59C_AW7PYNE=A@mail.gmail.com>
Message-ID: <20141008194541.GV868@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 09:18:44PM +0200, Nicolas Dechesne wrote:
> Georgi,
> 
> On Tue, Sep 2, 2014 at 5:40 PM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> > Enable support for the two SD host controllers on the APQ8084 platform
> > by adding the required nodes to the DT files.
> > On the IFC6540 board, the first controller is connected to the onboard
> > eMMC and the second is connected to a micro-SD card slot.
> 
> testing this set of patch on IFC6540, i noticed that not all
> partitions from the eMMC are detected. booting [1] which is basically
> 3.17-rc7 with a few additional patches, i can see the following
> relevant mmc traces:
> 
> [    1.162587] mmc0: BKOPS_EN bit is not set
> [    1.315357] mmc0: new HS200 MMC card at address 0001
> [    1.318098] mmcblk0: mmc0:0001 SEM16G 14.6 GiB
> [    1.330377] mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
> [    1.333652] mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
> [    1.345424] mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB
> [    1.358135]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15
> [    1.365902]  mmcblk0boot1: p1
> [    1.367833]  mmcblk0boot0: unknown partition table

This has bitten me more times than I care to admit, but have you checked
that you've set CONFIG_MMC_BLOCK_MINORS higher than 16?  Perhaps we
should be doing that in qcom_defconfig if we aren't already.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
