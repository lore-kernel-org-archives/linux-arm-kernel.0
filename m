From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 May 2017 11:24:08 +0200
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Enable NFS root
Message-ID: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable NFS root on the r8a7795/h3ulcb and r8a7796/m3ulcb
as per:
* commit b2407c566ba29215 ("arm64: dts: r8a7795: enable nfs root on Salvator-X board").
* commit 742a9dfb90f0 ("arm64: dts: r8a7796: salvator-x: Enable NFS root")

Also set ignore_loglevel rw as boot args as is the case for the boards
for the boards for other Renesas ARM/ARM64 based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile tested only due to lack of hardware access
* Based on renesas-devel-20170502-v4.11
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 2bc7ceb2efa4..7669b282bde2 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -21,6 +21,7 @@
 	};
 
 	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
2.1.4
