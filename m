From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 18 Feb 2014 10:40:18 -0600
Subject: [GIT PULL] qcom SoC changes for v3.15
In-Reply-To: <alpine.DEB.2.00.1402111516560.9530@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.00.1402111516560.9530@galak-ubuntu.qualcomm.com>
Message-ID: <5F62C529-4D77-4D33-A546-4780B50CE24C@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 11, 2014, at 3:19 PM, Kumar Gala <galak@codeaurora.org> wrote:

> The following changes since commit cf1e8f0cd665e2a9966d2bee4e11ecc0938ff166:
> 
>  ARM: qcom: Rename various msm prefixed functions to qcom (2014-02-06 16:20:41 -0600)
> 
> are available in the git repository at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-3.15
> 
> for you to fetch changes up to 6990c132abc984bd6e75ac2be1f1d657cd600f63:
> 
>  ARM: qcom: Add SMP support for KPSSv2 (2014-02-11 15:00:40 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based SoC Updates for v3.15
> 
> * Add support for determining smp ops based on device tree.
> * Add DT binding specs for Krait/Scorpion enable method
> * Add DT binding specs for various Krait Processor controller complexes
> * Add SoC SMP support for Krait Processor Subsystem v1 & v2
> 
> ----------------------------------------------------------------
> Rohit Vaswani (4):
>      ARM: qcom: Re-organize platsmp to make it extensible
>      devicetree: bindings: Document Krait/Scorpion cpus and enable-method
>      ARM: qcom: Add SMP support for KPSSv1
>      ARM: qcom: Add SMP support for KPSSv2
> 
> Stephen Boyd (3):
>      ARM: Introduce CPU_METHOD_OF_DECLARE() for cpu hotplug/smp
>      devicetree: bindings: Document qcom,kpss-acc
>      devicetree: bindings: Document qcom,saw2 node
> 
> Documentation/devicetree/bindings/arm/cpus.txt     |  25 +-
> .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  30 ++
> .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  35 +++
> arch/arm/include/asm/smp.h                         |   9 +
> arch/arm/kernel/devtree.c                          |  40 +++
> arch/arm/mach-msm/common.h                         |   2 -
> arch/arm/mach-qcom/board.c                         |  14 -
> arch/arm/mach-qcom/platsmp.c                       | 341 ++++++++++++++++++---
> arch/arm/mach-qcom/scm-boot.h                      |   8 +-
> include/asm-generic/vmlinux.lds.h                  |  10 +
> 10 files changed, 444 insertions(+), 70 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> 
> ?

ping

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
