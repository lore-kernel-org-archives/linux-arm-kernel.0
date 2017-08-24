From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 15:50:51 +0200
Subject: [GIT PULL 2/2] second round of Rockchip dts32 changes for 4.14
In-Reply-To: <2301603.fd1AhSc3fO@phil>
References: <4088347.CX4PhsiguF@phil> <2301603.fd1AhSc3fO@phil>
Message-ID: <CAK8P3a3SKUoNPzCQMgnV=g+f3twBM_9Gn-=k0znx4cMRkeb9cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:42 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> The following changes since commit 0f4dc7e154d054303c4dd6b5c3e3207f9a7f8714:
>
>   ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes (2017-07-22 22:41:35 +0200)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts32-2
>
> for you to fetch changes up to 274ff50d3ad951bca0adbfb9ffd628d35ba6db6f:
>
>   ARM: dts: rockchip: enable usb for rv1108-evb (2017-08-23 09:24:51 +0200)
>
> ----------------------------------------------------------------
> A lot of attention for the rv1108 soc targetted at media-processing
> (usb, operating points, spi, pwm, adc, watchdog, i2c and devices for
> its evb).
>
> RK3228/3229 gets iommu and spi nodes. Similar to the rk3288 which
> also gets some more iommu nodes as well as getting converted to 64
> bit addresses due to wanting to address more than 4GB of memory
> via LPAE.

Pulled into next/dt with a small fixup, see below. Please check.

Thanks!

      Arnd


diff --cc arch/arm/boot/dts/rk3288.dtsi
index 858e1fed762a,c0c04e99e159..356ed1e62452
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@@ -1126,9 -1145,27 +1145,27 @@@
                };
        };

+       vpu_mmu: iommu at ff9a0800 {
+               compatible = "rockchip,iommu";
+               reg = <0x0 0xff9a0800 0x0 0x100>;
+               interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+               interrupt-names = "vpu_mmu";
+               #iommu-cells = <0>;
+               status = "disabled";
+       };
+
+       hevc_mmu: iommu at ff9c0440 {
+               compatible = "rockchip,iommu";
+               reg = <0x0 0xff9c0440 0x0 0x40>, <0x0 0xff9c0480 0x0 0x40>;
+               interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+               interrupt-names = "hevc_mmu";
+               #iommu-cells = <0>;
+               status = "disabled";
+       };
+
 -      gpu: mali at ffa30000 {
 -              compatible = "rockchip,rk3288-mali", "arm,mali-t760",
"arm,mali-midgard";
 +      gpu: gpu at ffa30000 {
 +              compatible = "rockchip,rk3288-mali", "arm,mali-t760";
-               reg = <0xffa30000 0x10000>;
+               reg = <0x0 0xffa30000 0x0 0x10000>;
                interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
