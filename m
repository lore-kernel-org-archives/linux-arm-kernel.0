From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 06:39:35 -0600
Subject: [PATCH v2 4/6] OMAP3: id: add fallthrough warning;
	fix some CodingStyle issues
In-Reply-To: <20110914123708.25282.78122.stgit@dusk>
References: <20110914123708.25282.78122.stgit@dusk>
Message-ID: <20110914123931.25282.13790.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emit a warning to the console in omap3_check_revision() if that code
cannot determine what type of SoC the system is currently running on.

Remove some extra whitespace, remove some duplicate code, and
add an appropriate comment to a fallthrough case.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/id.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 6810c52..18c3797 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -336,8 +336,9 @@ static void __init omap3_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
 			break;
 		case 2:
+		/* FALLTHROUGH */
 		default:
-			omap_revision =  OMAP3630_REV_ES1_2;
+			omap_revision = OMAP3630_REV_ES1_2;
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
 		}
 		break;
@@ -349,16 +350,16 @@ static void __init omap3_check_revision(void)
 			omap_revision = TI8168_REV_ES1_0;
 			break;
 		case 1:
-			omap_revision = TI8168_REV_ES1_1;
-			break;
+		/* FALLTHROUGH */
 		default:
-			omap_revision =  TI8168_REV_ES1_1;
+			omap_revision = TI8168_REV_ES1_1;
 		}
 		break;
 	default:
-		/* Unknown default to latest silicon rev as default*/
+		/* Unknown default to latest silicon rev as default */
 		omap_revision =  OMAP3630_REV_ES1_2;
 		omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
+		pr_warn("Warning: unknown chip type; assuming OMAP3630ES1.2\n");
 	}
 }
 
