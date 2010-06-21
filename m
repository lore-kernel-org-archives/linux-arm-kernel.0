From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 10:13:59 +0100
Subject: [PATCH v3 6/7] ARM: Remove dummy loads from the original relocation
	address
In-Reply-To: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621091359.22752.31023.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading back the upper and lower values in the R_ARM_THM_CALL and
R_ARM_THM_JUMP24 case was introduced by a previous commit but they are
not needed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/module.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index ae3c804..aab7fca 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -233,8 +233,6 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			*(u16 *)(loc + 2) = (u16)((lower & 0xd000) |
 						  (j1 << 13) | (j2 << 11) |
 						  ((offset >> 1) & 0x07ff));
-			upper = *(u16 *)loc;
-			lower = *(u16 *)(loc + 2);
 			break;
 
 		case R_ARM_THM_MOVW_ABS_NC:
