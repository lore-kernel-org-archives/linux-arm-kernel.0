From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:18 +0200
Subject: [PATCH 07/14] arm64: dts: renesas: ulcb: add default bootargs
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <ae3d16b93c2a510da003aecb39db3aaaab1a81b0.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It can't boot without bootargs settings on Uboot on ulcb board.
This patch adds missing default bootargs.
ulcb BSP can overwrite it by own UBoot settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 30506c5ba4e9..89daca7356df 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -18,6 +18,7 @@
 	};
 
 	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
2.11.0
