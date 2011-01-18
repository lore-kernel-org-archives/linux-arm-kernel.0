From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 18 Jan 2011 13:29:38 -0700
Subject: [PATCH 8/8] arm/dt: Basic tegra devicetree support
In-Reply-To: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
References: <20110118195933.13011.56098.stgit@localhost6.localdomain6>
Message-ID: <20110118202938.13011.35918.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds adds very basic support for booting versatile with a
device tree.  It simply allows the existing machine_descs to match
against the tegra compatible values so that the kernel can boot.
Kernel parameters and the initrd pointer is read out of the tree
instead of atags.

This is not complete device tree support.  This change will be
reverted when a new machine_desc is added that can populate the
versatile device registrations directly from data in the tree instead
of using hard coded data.  That change will be made in a future patch.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-tegra/board-harmony.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index b9dbdb1..99884e9 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -113,6 +113,11 @@ static void __init tegra_harmony_init(void)
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
 }
 
+static const char * tegra_harmony_board_compat[] = {
+	"nvidia,harmony",
+	NULL
+};
+
 MACHINE_START(HARMONY, "harmony")
 	.boot_params  = 0x00000100,
 	.fixup		= tegra_harmony_fixup,
@@ -120,4 +125,5 @@ MACHINE_START(HARMONY, "harmony")
 	.init_machine   = tegra_harmony_init,
 	.map_io         = tegra_map_common_io,
 	.timer          = &tegra_timer,
+	.dt_compat      = tegra_harmony_board_compat,
 MACHINE_END
