From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:11:01 +0530
Subject: [PATCH V3 3/7] SPEAr6xx: Add compilation support for dtbs using 'make
 dtbs'
In-Reply-To: <cover.1333017183.git.viresh.kumar@st.com>
References: <cover.1333017183.git.viresh.kumar@st.com>
Message-ID: <b60bcdd8cca9d6d2bca5741344708599cae4f591.1333017183.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'make dtbs' compiles all dtbs for a family. For this we need to add entries for
all board dtb's in Makefile.boot file. This patch does it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear6xx/Makefile.boot |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
index 4674a4c..af493da 100644
--- a/arch/arm/mach-spear6xx/Makefile.boot
+++ b/arch/arm/mach-spear6xx/Makefile.boot
@@ -1,3 +1,5 @@
 zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_BOARD_SPEAR600_DT)	+= spear600-evb.dtb
-- 
1.7.9
