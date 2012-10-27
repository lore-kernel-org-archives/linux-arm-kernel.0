From: michal.simek@xilinx.com (Michal Simek)
Date: Sat, 27 Oct 2012 13:39:00 +0000
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
Message-ID: <0d1c4cf8-70d8-4d12-bd77-393009d32b22@CH1EHSMHS001.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Wednesday, October 24, 2012 10:03 PM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
>
> The Zynq uses the cortex-a9-gic.  This eliminates the need to hardcode register
> addresses.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/zynq-ep107.dts           | 8 +++++---
>  arch/arm/mach-zynq/common.c                | 7 ++++++-
>  arch/arm/mach-zynq/include/mach/zynq_soc.h | 2 --
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-ep107.dts b/arch/arm/boot/dts/zynq-
> ep107.dts
> index 37ca192..7bfff4a 100644
> --- a/arch/arm/boot/dts/zynq-ep107.dts
> +++ b/arch/arm/boot/dts/zynq-ep107.dts
> @@ -36,10 +36,12 @@
>               ranges;
>
>               intc: interrupt-controller at f8f01000 {
> +                     compatible = "arm,cortex-a9-gic";
> +                     #interrupt-cells = <3>;

If you change git to 3 cells format you should also change it for uart below.

Also will be the best to remove this dts entirely and replace it by existing
Platform.

Thanks,
Michal


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
