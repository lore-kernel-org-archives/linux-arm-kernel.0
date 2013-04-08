From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 07 Apr 2013 20:16:41 -0700 (PDT)
Subject: [RFC/PATCH 0/7] ARCH: shmobile: defconfig consolidation
In-Reply-To: <87mwt9ohsx.wl%kuninori.morimoto.gx@renesas.com>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
 <87sj31omnz.wl%kuninori.morimoto.gx@renesas.com>
 <20130408021630.GI13103@verge.net.au>
 <87mwt9ohsx.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87li8togoa.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > Unfortunately not, the idea is not to modify CONFIG_MEMORY_START
> > or CONFIG_MEMORY_SIZE.
> > 
> > My understanding is that if you load a zImage at the correct
> > start address (0x60000000 IIRC) and then execute it using bootz
> > then the kernel should relocate and run from that address.
> 
> Hmm...
> This means 3) is not needed, but it didn't work without 3)
> Is it R8A7778 or Bock-W DT code issue ?

Now, Bock-W start works with attached patch
Is it correct for you ?

I used simon/topic/defconfig-consolidation+next-20130403
(I guess there is no tag for it ?)

-- for bock-w ---------------------------
diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 0076b1e..1242940 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -27,6 +27,6 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x60000000 0x10000000>;
+		reg = <0x40000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7dba53f..c4b9940 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,10 +14,12 @@ CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MACH_ARMADILLO800EVA=y
+CONFIG_MACH_BOCKW=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_KZM9D=y
 # CONFIG_SH_TIMER_TMU is not set


Best regards
---
Kuninori Morimoto
