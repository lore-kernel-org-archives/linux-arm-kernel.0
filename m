From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Jun 2017 15:30:27 -0700
Subject: [PATCH v6 00/11] Broadcom Stingray SOC Initial Support
In-Reply-To: <c26e95e1-4bfa-0d24-33cc-8d5ae3102864@gmail.com>
References: <1496385275-6899-1-git-send-email-anup.patel@broadcom.com>
 <4c15213f-4ac6-a0a7-f2b8-cde2b4cee891@gmail.com>
 <c26e95e1-4bfa-0d24-33cc-8d5ae3102864@gmail.com>
Message-ID: <20170606223027.GL20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05, Florian Fainelli wrote:
> 
> 
> On 06/05/2017 09:51 AM, Florian Fainelli wrote:
> > On 06/01/2017 11:34 PM, Anup Patel wrote:
> >> This patchset adds initial support of Broadcom Stingray SOC
> >> by reusing existing Broadcom iProc device drivers.
> >>
> >> Most of the patches in this patchset are DT patches except
> >> the Stingray clock tree support which just one patch.
> >>
> >> This patchset is based on Linux-4.12-rc3 and it is also available
> >> at stingray-v6 branch of https://github.com/Broadcom/arm64-linux.git
> >>
> >> Changes since v5:
> >>  - Rebased patches for Linux-4.12-rc3
> >>  - Update DT node names to match register offset
> >>
> >> Changes since v4:
> >>  - Reduce number of include headers in Stingray clk driver
> >>
> >> Changes since v3:
> >>  - Rebased patches for Linux-4.12-rc1
> >>  - Updated PATCH3 to have all clocks except genpll3 to be
> >>    registered via platform driver probe
> >>
> >> Changes since v2:
> >>  - Remove default bootargs from chosen DT node
> >>  - Remove "linux" prefix from stdout DT attribute of chosen DT node
> >>  - Remove use of GIC_CPU_MASK_xxx() for PPIs
> >>
> >> Changes since v1:
> >>  - Rebased patches for Linux-4.12-rc1
> >>  - Removed unwanted /memreserve/ from bcm958742-base.dtsi
> >>  - Use ranges DT property to clear view of memory-layout
> >>  - Make bcm-sr.h part of clock DT bindings patch
> >>
> >> Anup Patel (3):
> >>   dt-bindings: bcm: Add Broadcom Stingray bindings document
> >>   arm64: dts: Initial DTS files for Broadcom Stingray SOC
> >>   arm64: dts: Add PL022, PL330 and SP805 DT nodes for Stingray
> >>
> >> Oza Pawandeep (1):
> >>   arm64: dts: Add I2C DT nodes for Stingray SoC
> >>
> >> Pramod Kumar (3):
> >>   arm64: dts: Add NAND DT nodes for Stingray SOC
> >>   arm64: dts: Add pinctrl DT nodes for Stingray SOC
> >>   arm64: dts: Add GPIO DT nodes for Stingray SOC
> >>
> >> Sandeep Tripathy (3):
> >>   dt-bindings: clk: Extend binding doc for Stingray SOC
> >>   clk: bcm: Add clocks for Stingray SOC
> >>   arm64: dts: Add clock DT nodes for Stingray SOC
> >>
> >> Srinath Mannam (1):
> >>   arm64: dts: Add PWM and SDHCI DT nodes for Stingray SOC
> > 
> > Applied patches 1, 4-11 to devicetree-arm64/next, thanks!
> 
> Also took patch 2, to make sure everything builds properly, Stephen, let
> me know if you want me to take patch #3 as well.
> 

Usually clk tree takes includes and hosts that in a stable branch
for arm-soc maintainers to take. It seems that now arm-soc
maintainers are asking that dts files use plain numbers and then
switch to defines later after -rc1.

Should I go apply patch 2 myself so I can apply patch 3 to the
clk tree? Personally, I think this is fine because git doesn't
care about duplicate commits anyway and this is just #defines
we're talking about. Alternatively, you can host patch 2 in a
stable branch on v4.12-rc1 that I can pull into clk tree and then
apply patch 3 on top of and merge up into clk-next. Or you can
send me a PR for this clk driver and I can merge it into clk-next
where patch 2 is the parent of the clk driver change.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
