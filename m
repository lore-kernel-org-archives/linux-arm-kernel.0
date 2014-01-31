From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 31 Jan 2014 13:25:25 -0600
Subject: [PATCH 2/4] arm: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <201401312020.16984.arnd@arndb.de>
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
 <1391107002-21470-3-git-send-email-galak@codeaurora.org>
 <201401312020.16984.arnd@arndb.de>
Message-ID: <2B2190A4-6689-40D8-A3D7-BD2D882A2CF6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 31, 2014, at 1:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 30 January 2014, Kumar Gala wrote:
>> Introduce a new mach-qcom that will support SoCs that intend to be
>> multiplatform compatiable while keeping mach-msm to legacy SoC/board
>> support that will not transition over to multiplatform.
>> 
>> As part of this, we move support for MSM8X60, MSM8960 and MSM8974 over
>> to mach-qcom.
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> MAINTAINERS                                        |  7 +++
>> arch/arm/Kconfig                                   |  7 +--
>> arch/arm/Makefile                                  |  1 +
>> arch/arm/boot/dts/Makefile                         |  6 +--
>> arch/arm/mach-msm/Kconfig                          | 45 +------------------
>> arch/arm/mach-msm/Makefile                         |  7 ---
>> arch/arm/mach-msm/hotplug.c                        | 51 ----------------------
>> arch/arm/mach-qcom/Kconfig                         | 34 +++++++++++++++
>> arch/arm/mach-qcom/Makefile                        |  5 +++
>> .../arm/{mach-msm/board-dt.c => mach-qcom/board.c} |  9 ++--
>> arch/arm/{mach-msm => mach-qcom}/scm-boot.c        |  0
>> arch/arm/{mach-msm => mach-qcom}/scm-boot.h        |  0
>> arch/arm/{mach-msm => mach-qcom}/scm.c             |  0
>> arch/arm/{mach-msm => mach-qcom}/scm.h             |  0
>> arch/arm/{mach-msm/platsmp.c => mach-qcom/smp.c}   | 11 ++++-
> 
> The hotplug.c change sticks out as something that isn't just a move
> of code to another place, but deletion of unused code. It would
> be nice to split that out into a separate change, possibly together
> with the trivial board.c and smp.c changes.

That?s not 100% true, the hotplug.c code implemented msm_cpu_die, which moved into smp.c

I can split out scm*/smp* into a patch to enable smp if that is really desired, but not exactly sure what it gets us.


- k
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
