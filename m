From: john.stultz@linaro.org (John Stultz)
Date: Wed, 18 Jul 2018 11:58:06 -0700
Subject: [PATCH v11 0/4] [RESEND] scsi: ufs: add ufs driver code for
 Hisilicon Hi3660 SoC
In-Reply-To: <20180717093659.103263-1-liwei213@huawei.com>
References: <20180717093659.103263-1-liwei213@huawei.com>
Message-ID: <CALAqxLVgRCCPJhjdpqG9TejtdNzHbyasxBytObgrS5_LrQnTtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 2:36 AM, Li Wei <liwei213@huawei.com> wrote:
> This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.
>
> Li Wei (4):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/scsi/ufs/Kconfig                           |   9 +
>  drivers/scsi/ufs/Makefile                          |   1 +
>  drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
>  drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
>  8 files changed, 811 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.c
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.h


Martin/Vinayak: Wanted to nudge either of you to see if you had any
further feedback or objections on this patchset? Its been a long slow
slog for this patch-set and getting it upstream will make the HiKey960
board much more useful for testing mainline kernels.

If you don't have objections, would you consider merging the scsi
driver and Acked dt-bindings via the scsi tree?   Including the dts
changes too if Wei Xu (now cc'ed) acks it, would be helpful as well
(but that can go separately later if necessary).

The defconfig change isn't as important, so I suspect can be re-pushed
through the ARM maintainers later.

thanks
-john
