From: tony@atomide.com (Tony Lindgren)
Date: Fri, 03 Feb 2012 12:55:05 -0800
Subject: [PATCH 1/2] pinmux: Export pinmux_register_mappings for pinmux modules
In-Reply-To: <20120203205049.4089.74610.stgit@kaulin.local>
References: <20120203205049.4089.74610.stgit@kaulin.local>
Message-ID: <20120203205505.4089.67339.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With devidce tree based pinmux drivers we may not have
static pinmux mappings as they can be dynamically created
based on the device tree entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinmux.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 7c3193f..140d207 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(pinmux_gpio_direction_output);
  * passed into this function will be owned by the pinmux core and cannot be
  * freed.
  */
-int __init pinmux_register_mappings(struct pinmux_map const *maps,
+int pinmux_register_mappings(struct pinmux_map const *maps,
 				    unsigned num_maps)
 {
 	void *tmp_maps;
@@ -402,6 +402,7 @@ int __init pinmux_register_mappings(struct pinmux_map const *maps,
 	pinmux_maps_num += num_maps;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pinmux_register_mappings);
 
 /**
  * acquire_pins() - acquire all the pins for a certain function on a pinmux
