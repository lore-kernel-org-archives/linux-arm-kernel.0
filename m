From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:19:51 +0200
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
Message-ID: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linux code in drivers/mtd/maps/physmap_of.c will optionally
look for this binding for hints on a partition type to look for
in the MTD. It was added in commit 9d5da3a9b849
"mtd: extend physmap_of to let the device tree specify the parition probe"
but no corresponding device tree binding was added. Fix this.

Cc: devicetree at vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Reported-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 4a0a48bf4ecb..0dee084651da 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -26,6 +26,9 @@ file systems on embedded devices.
  - linux,mtd-name: allow to specify the mtd name for retro capability with
    physmap-flash drivers as boot loader pass the mtd partition via the old
    device name physmap-flash.
+ - linux,part-probe: a flash partition type to look for, using the
+   Linux-internal partition naming scheme, e.g. "afs" for the ARM
+   Flash footers.
  - use-advanced-sector-protection: boolean to enable support for the
    advanced sector protection (Spansion: PPB - Persistent Protection
    Bits) locking.
-- 
2.4.3
