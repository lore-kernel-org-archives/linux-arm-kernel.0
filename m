From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 05 Aug 2013 20:17:33 -0700 (PDT)
Subject: [PATCH 2/2] ARM: shmobile: kzm9d: remove nfsroot settings from
 bootargs
In-Reply-To: <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
 <20130806010736.GA20940@verge.net.au>
 <87r4e7h88z.wl%kuninori.morimoto.gx@renesas.com>
 <20130806022955.GA25114@verge.net.au>
 <87pptrh6f3.wl%kuninori.morimoto.gx@renesas.com>
 <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87li4fh5it.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFS detail settings like "nfsroot=,rsize=4096,wsize=4096" are no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/emev2-kzm9d-reference.dts |    2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d-reference.dts b/arch/arm/boot/dts/emev2-kzm9d-reference.dts
index bed676b..cceefda 100644
--- a/arch/arm/boot/dts/emev2-kzm9d-reference.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d-reference.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
 	reg_1p8v: regulator at 0 {
diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index dda13bc..f92e812 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -21,6 +21,6 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 };
-- 
1.7.9.5
