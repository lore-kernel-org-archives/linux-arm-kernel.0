From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Fri, 04 Mar 2011 14:42:29 -0800
Subject: [PATCH 0/3] ARM: Add Scorpion/ScorpionMP support to perf and
	Oprofile
In-Reply-To: <1299276551-11978-1-git-send-email-sheetals@codeaurora.org>
References: <1299276551-11978-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <4D716AD5.1070403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2011 02:09 PM, Sheetal Sahasrabudhe wrote:
> This patchset contains the following features:
> It adds support for Qualcomm Scorpion and ScorpionMP processors to perfevents
> and Oprofile.
> It adds PMU support for Scorpion and ScorpionMP.
> It also updates PMU IRQ identifiers for various Scorpion and ScorpionMP targets.
> 
> Sheetal Sahasrabudhe (3):
>   msm: Add support for Scorpion and ScorpionMP PMU
>   [ARM] perfevents: Add support for Scorpion performance monitors
>   [ARM] Oprofile: Add Qualcomm Scorpion and ScorpionMP CPU type
> 
>  arch/arm/include/asm/perf_event.h          |    2 +
>  arch/arm/kernel/perf_event.c               |   11 +
>  arch/arm/kernel/perf_event_qc.c            |  677 ++++++++++++++++++++++++++++
>  arch/arm/mach-msm/Makefile                 |    2 +
>  arch/arm/mach-msm/include/mach/irqs-7x30.h |    2 +-
>  arch/arm/mach-msm/include/mach/irqs-8960.h |    2 +-
>  arch/arm/mach-msm/include/mach/irqs-8x50.h |    2 +-
>  arch/arm/mach-msm/include/mach/irqs-8x60.h |    2 +-
>  arch/arm/mach-msm/pmu.c                    |   36 ++
>  arch/arm/oprofile/common.c                 |    4 +
>  10 files changed, 736 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event_qc.c
>  create mode 100644 arch/arm/mach-msm/pmu.c
> 

Some minor comments from a quick review:
- you're using multi-line commenting style for single line comments
- see Documentation/CodingStyle, Chapter 8, for preferred multi-line
commenting style
- 'mv perf_event_qc.c perf_event_msm.c'?

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
