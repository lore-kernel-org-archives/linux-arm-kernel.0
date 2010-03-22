From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Mar 2010 15:19:50 +0000
Subject: [PATCH 3/5] ARM: Correct the VFPv3 detection
In-Reply-To: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100322151950.6353.47048.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A CPU has VFPv3 hardware if the FPSID[19:16] bits are 2 or more.
Currently Linux was only checking for 3 or more.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 7f3f59f..a420cb9 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -545,7 +545,7 @@ static int __init vfp_init(void)
 		 */
 		elf_hwcap |= HWCAP_VFP;
 #ifdef CONFIG_VFPv3
-		if (VFP_arch >= 3) {
+		if (VFP_arch >= 2) {
 			elf_hwcap |= HWCAP_VFPv3;
 
 			/*
