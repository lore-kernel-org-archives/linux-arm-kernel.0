From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Mar 2010 01:56:49 -0600
Subject: [PATCH 2/4] OMAP: HWMOD: Bug fixes in hwmod structure definitions
In-Reply-To: <20100330074801.11629.61888.stgit@localhost.localdomain>
References: <20100330074801.11629.61888.stgit@localhost.localdomain>
Message-ID: <20100330075645.11629.92446.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thara Gopinath <thara@ti.com>

This patch corrects the width of sysc_flags in hwmod sysconfig structure
where the values to be stored to this variable exceed the current
field width.

Signed-off-by: Thara Gopinath <thara@ti.com>
[paul at pwsan.com: edited to apply; rearranged structure members to pack]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 440b416..36d6ea5 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -294,8 +294,8 @@ struct omap_hwmod_class_sysconfig {
 	u16 rev_offs;
 	u16 sysc_offs;
 	u16 syss_offs;
+	u16 sysc_flags;
 	u8 idlemodes;
-	u8 sysc_flags;
 	u8 clockact;
 	struct omap_hwmod_sysc_fields *sysc_fields;
 };
