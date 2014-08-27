From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Aug 2014 19:43:54 +0100
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <CAOMZO5DgPLHwDsRPkssRDT5tKyfOo=Udg6vD5VPUQ43wsV346w@mail.gmail.com>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
 <CAOMZO5C=xyYLLBX1PDsJQ9NwzXZxCWTvPMTUWzYcoohOOvA_qA@mail.gmail.com>
 <20140823133649.GP30401@n2100.arm.linux.org.uk>
 <CAOMZO5DrtrEJxmCZSO6RVZom8kzZhu2dikntRwYZeq5j_QZ9sw@mail.gmail.com>
 <20140823143305.GQ30401@n2100.arm.linux.org.uk>
 <CAOMZO5DgPLHwDsRPkssRDT5tKyfOo=Udg6vD5VPUQ43wsV346w@mail.gmail.com>
Message-ID: <20140827184354.GA30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 12:02:05PM -0300, Fabio Estevam wrote:
> On Sat, Aug 23, 2014 at 11:33 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Most of the pins not associated with booting the kernel are left
> > unconfigured by the boot loader - that's because uboot SPL has very
> > little space for such things.
> >
> > Rabeeh has just told me that 0x1b0b1 would be a better value for it.
> > I'll add an additional patch to the series for that, rather than
> > modifying Rabeeh's original patch.
> 
> Sounds good, thanks.

Right, here's the patch to make that change.  Shawn, can you pick this
one up as well please?

Thanks.

8<===
>From 5cebff8f6232fbafde7af564eca61447f951040e Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Sat, 23 Aug 2014 15:34:07 +0100
Subject: [PATCH] ARM: dts: hummingboard: fix configuration of IR input

Add the IOMUX setting for the IR input, rather than relying on the
boot loader.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 4aa0ae357b00..7fe29de89e9d 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -130,7 +130,7 @@
 
 		pinctrl_hummingboard_gpio3_5: hummingboard-gpio3_5 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x1b0b1
 			>;
 		};
 
-- 
1.8.3.1



-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
