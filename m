From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 1 Mar 2011 12:23:14 +0530
Subject: [PATCH v2 5/9] OMAP2+: hwmod: rename some init functions
In-Reply-To: <20110228211217.15286.26420.stgit@twilight.localdomain>
References: <20110228210858.15286.3200.stgit@twilight.localdomain>
	<20110228211217.15286.26420.stgit@twilight.localdomain>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A21418B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

/**
- * omap_hwmod_late_init - do some post-clock framework initialization
+ * omap_hwmod_setup - do some post-clock framework initialization
Very minor comment: omap_hwmod_setup_all
--
Tarun
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-static int __init omap_hwmod_late_init(void)
+static int __init omap_hwmod_setup_all(void)
 {
 	int r;
