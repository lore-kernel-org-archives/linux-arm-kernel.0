From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:25 +0800
Subject: [PATCH 4/9] arm64: dts: ls208xa: Add the identify of the platform to
 support to set rcpm bit
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-4-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add the identify of the platform to support set the rcpm with
big-endian or little-endian.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index fec61af..973e646 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -896,9 +896,11 @@
 		};
 
 		ftm0: ftm0 at 2800000 {
-			compatible = "fsl,ftm-alarm";
-			reg = <0x0 0x2800000 0x0 0x10000>;
+			compatible = "fsl,ls208xa-ftm";
+			reg = <0x0 0x2800000 0x0 0x10000>,
+			      <0x0 0x1e34050 0x0 0x4>;
 			interrupts = <0 44 4>;
+			reg-names = "ftm", "FlexTimer1";
 		};
 	};
 
-- 
1.7.1
