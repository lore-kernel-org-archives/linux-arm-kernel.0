From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:27:41 +0900
Subject: [PATCH 02/08] ARM: shmobile: Update KZM9D dts command line
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
References: <20130702092725.32066.54861.sendpatchset@w520>
Message-ID: <20130702092741.32066.76218.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the KZM9D DTS command line to remove following cruft:
 - console=tty0 - no graphic support upstream anyway
 - earlyprintk= - not supported by the 8250-em driver anyway
 - mem= - this is provided via DT anyway

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/emev2-kzm9d.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/emev2-kzm9d.dts
+++ work/arch/arm/boot/dts/emev2-kzm9d.dts	2013-07-02 17:07:18.000000000 +0900
@@ -21,6 +21,6 @@
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttyS1,115200n81 earlyprintk=serial8250-em.1,115200n81 mem=128M at 0x40000000 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
 	};
 };
