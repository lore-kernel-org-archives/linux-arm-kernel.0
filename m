From: giridhar.maruthy@linaro.org (Giridhar Maruthy)
Date: Thu, 21 Mar 2013 15:13:17 +0530
Subject: Fwd: [PATCH] ARM: EXYNOS5440: DTS: Add virtual GIC DT bindings
In-Reply-To: <1363858839-13578-1-git-send-email-giridhar.maruthy@linaro.org>
References: <1363858839-13578-1-git-send-email-giridhar.maruthy@linaro.org>
Message-ID: <CAHuqX+G=LhpO_WuOYSEwVGDOtKU-Nby2j--xt-bLk2P3jyEsyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is similar to the ones already submitted by Alexander Graf
and also in Christoffer's tree in linux-kvm-arm for Arndale board,
while this is required for exynos5440.




Exynos5440 has GIC which has virtualization support
in them. These are used by KVM.

Signed-off-by: Giridhar Maruthy <giridhar.m@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi
b/arch/arm/boot/dts/exynos5440.dtsi
index c374a31..25c6134 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -26,7 +26,11 @@
                compatible = "arm,cortex-a15-gic";
                #interrupt-cells = <3>;
                interrupt-controller;
-               reg = <0x2E1000 0x1000>, <0x2E2000 0x1000>;
+               reg =   <0x2E1000 0x1000>,
+                       <0x2E2000 0x1000>,
+                       <0x2E4000 0x2000>,
+                       <0x2E6000 0x2000>;
+               interrupts = <1 9 0xf04>;
        };

        cpus {
--
1.7.9.5
