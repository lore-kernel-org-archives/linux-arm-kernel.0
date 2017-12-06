From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 06 Dec 2017 08:24:56 -0800
Subject: [Intel-wired-lan] [PATCH 1/1] timecounter: Make cyclecounter
 struct part of timecounter struct
In-Reply-To: <1512189095-28654-1-git-send-email-sagar.a.kamble@intel.com>
References: <1512189095-28654-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1512577496.8693.0.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-12-02 at 10:01 +0530, Sagar Arun Kamble wrote:
> There is no real need for the users of timecounters to define
> cyclecounter
> and timecounter variables separately. Since timecounter will always
> be
> based on cyclecounter, have cyclecounter struct as member of
> timecounter
> struct.
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

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the changes to the Intel drivers.

> ---
>  arch/microblaze/kernel/timer.c                     | 20 ++++++------
>  drivers/clocksource/arm_arch_timer.c               | 19 ++++++------
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  3 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |  9 +++---
>  drivers/net/ethernet/amd/xgbe/xgbe.h               |  1 -
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  1 -
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 20 ++++++------
>  drivers/net/ethernet/freescale/fec.h               |  1 -
>  drivers/net/ethernet/freescale/fec_ptp.c           | 30 +++++++++---
> ------
>  drivers/net/ethernet/intel/e1000e/e1000.h          |  1 -
>  drivers/net/ethernet/intel/e1000e/netdev.c         | 27 ++++++++--
> ------
>  drivers/net/ethernet/intel/e1000e/ptp.c            |  2 +-
>  drivers/net/ethernet/intel/igb/igb.h               |  1 -
>  drivers/net/ethernet/intel/igb/igb_ptp.c           | 25 ++++++++--
> -----
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h           |  1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       | 17 +++++-----
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c      | 28 ++++++++--
> -------
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |  1 -
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 34 ++++++++++
> ----------
>  drivers/net/ethernet/qlogic/qede/qede_ptp.c        | 20 ++++++------
>  drivers/net/ethernet/ti/cpts.c                     | 36
> ++++++++++++----------
>  drivers/net/ethernet/ti/cpts.h                     |  1 -
>  include/linux/mlx5/driver.h                        |  1 -
>  include/linux/timecounter.h                        |  4 +--
>  include/sound/hdaudio.h                            |  1 -
>  kernel/time/timecounter.c                          | 28 ++++++++--
> -------
>  sound/hda/hdac_stream.c                            |  7 +++--
>  virt/kvm/arm/arch_timer.c                          |  6 ++--
>  28 files changed, 163 insertions(+), 182 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/25c2f7ee/attachment-0001.sig>
