From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Jun 2013 10:05:45 +0100
Subject: [RFC PATCH v3 0/2] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130611090545.GC8164@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

if nobody has objections I think this set is ready to get merged. As
Nico mentioned in:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173541.html

since we would like to get it merged through the ARM SoC tree owing to
dependencies between this code and ARM power management back-ends, your ack
would be appreciated, if you think it is worth it of course.

Thank you very much indeed,
Lorenzo

On Thu, Jun 06, 2013 at 10:59:21AM +0100, Lorenzo Pieralisi wrote:
> This patch is v3 of a previous posting:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173464.html
> 
> v3 changes:
> 
> - added __refdata to spc_check_loaded pointer
> - removed some exported symbols
> - added node pointer check in vexpress_spc_init()
> 
> v2 changes:
> 
> - Dropped timeout interface patch
> - Converted interfaces to non-timeout ones, integrated and retested
> - Removed mutex used at init
> - Refactored code to work around init sections warning
> - Fixed two minor bugs
> 
> This patch series introduces support for the Versatile Express Serial
> Power Controller (SPC) present in ARM Versatile Express TC2 core tiles.
> SPC driver is a fundamental component of TC2 power management and allows
> to carry out C-state management and DVFS for A15 and A7 clusters.
> 
> First patch provides changes required by SPC to comply with the
> Versatile Express config API, second patch is the SPC driver implementation.
> 
> Code extensively exercised through CPUidle and CPUfreq power states and
> operating point transitions.
> 
> Lorenzo Pieralisi (1):
>   drivers: mfd: vexpress: add Serial Power Controller (SPC) support
> 
> Pawel Moll (1):
>   drivers: mfd: refactor the vexpress config bridge API
> 
>  Documentation/devicetree/bindings/mfd/vexpress-spc.txt |  35 +
>  drivers/mfd/Kconfig                                    |   7 +
>  drivers/mfd/Makefile                                   |   1 +
>  drivers/mfd/vexpress-config.c                          |  61 +-
>  drivers/mfd/vexpress-spc.c                             | 633 ++++++++++
>  drivers/mfd/vexpress-sysreg.c                          |   2 +-
>  include/linux/vexpress.h                               |  59 +-
>  7 files changed, 770 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/vexpress-spc.txt
>  create mode 100644 drivers/mfd/vexpress-spc.c
> 
> -- 
> 1.8.2.2
> 
