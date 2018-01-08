From: aaron.f.brown@intel.com (Brown, Aaron F)
Date: Mon, 8 Jan 2018 22:20:35 +0000
Subject: [Intel-wired-lan] [PATCH 01/27] timecounter: Make cyclecounter
 struct part of timecounter struct
In-Reply-To: <1513323522-15021-2-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-2-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C734DF8@ORSMSX101.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sagar Arun Kamble
> Sent: Thursday, December 14, 2017 11:38 PM
> To: linux-kernel at vger.kernel.org
> Cc: alsa-devel at alsa-project.org; linux-rdma at vger.kernel.org;
> netdev at vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> Stephen Boyd <sboyd@codeaurora.org>; Chris Wilson <chris@chris-
> wilson.co.uk>; John Stultz <john.stultz@linaro.org>; intel-wired-
> lan at lists.osuosl.org; Thomas Gleixner <tglx@linutronix.de>; Kamble, Sagar A
> <sagar.a.kamble@intel.com>; kvmarm at lists.cs.columbia.edu; linux-arm-
> kernel at lists.infradead.org
> Subject: [Intel-wired-lan] [PATCH 01/27] timecounter: Make cyclecounter
> struct part of timecounter struct
> 
> There is no real need for the users of timecounters to define cyclecounter
> and timecounter variables separately. Since timecounter will always be
> based on cyclecounter, have cyclecounter struct as member of timecounter
> struct.
> 
> v2: Rebase.
> 
> Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: linux-rdma at vger.kernel.org
> Cc: alsa-devel at alsa-project.org
> Cc: kvmarm at lists.cs.columbia.edu
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com> (Intel drivers)
> ---
>  arch/microblaze/kernel/timer.c                     | 20 ++++++------
>  drivers/clocksource/arm_arch_timer.c               | 19 ++++++------
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  3 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |  9 +++---
>  drivers/net/ethernet/amd/xgbe/xgbe.h               |  1 -
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  1 -
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 20 ++++++------
>  drivers/net/ethernet/freescale/fec.h               |  1 -
>  drivers/net/ethernet/freescale/fec_ptp.c           | 30 +++++++++---------
>  drivers/net/ethernet/intel/e1000e/e1000.h          |  1 -
>  drivers/net/ethernet/intel/e1000e/netdev.c         | 27 ++++++++--------
>  drivers/net/ethernet/intel/e1000e/ptp.c            |  2 +-
>  drivers/net/ethernet/intel/igb/igb.h               |  1 -
>  drivers/net/ethernet/intel/igb/igb_ptp.c           | 25 ++++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       | 17 +++++-----
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c      | 28 ++++++++---------
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |  1 -
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 34 ++++++++++----------
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c        | 20 ++++++------
>  drivers/net/ethernet/ti/cpts.c                     | 36 ++++++++++++----------
>  drivers/net/ethernet/ti/cpts.h                     |  1 -
>  include/linux/mlx5/driver.h                        |  1 -
>  include/linux/timecounter.h                        |  4 +--
>  include/sound/hdaudio.h                            |  1 -
>  kernel/time/timecounter.c                          | 28 ++++++++---------
>  sound/hda/hdac_stream.c                            |  7 +++--
>  virt/kvm/arm/arch_timer.c                          |  6 ++--
>  28 files changed, 163 insertions(+), 182 deletions(-)
> 

For Intel e1000e and igb drivers:
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
