From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Jan 2017 12:12:51 +0000
Subject: [PATCH 2/3] arm64: dts: juno: Add ETR SMMU power domain
In-Reply-To: <74595d6d866518db7cfabc39b4cf9b54d3be9bde.1484741104.git.robin.murphy@arm.com>
References: <74595d6d866518db7cfabc39b4cf9b54d3be9bde.1484741104.git.robin.murphy@arm.com>
Message-ID: <55add42885c182648ff466254176e43e66137597.1484741104.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not at all clear from the documentation, but straightforward to
determine in practice, that the ETR SMMU is actually in the DEBUGSYS
power domain. Add that to the DT so that anyone brave enough to enable
said SMMU doesn't experience a system lockup on boot, especially a
sneaky one which goes away as soon as you connect an external debugger
to have a look at where it's stuck (thus powering up DEBUGSYS by other
means and allowing it to make progress again before actually halting...)

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 5e7640d6ec69..37225dfdc995 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -52,6 +52,7 @@
 		#iommu-cells = <1>;
 		#global-interrupts = <1>;
 		dma-coherent;
+		power-domains = <&scpi_devpd 0>;
 		status = "disabled";
 	};
 
-- 
2.11.0.dirty
