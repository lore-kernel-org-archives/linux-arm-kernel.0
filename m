From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 19 Aug 2012 22:29:33 +0300
Subject: [PATCH 1/8] arm: sam9_l9260_defconfig: adjust UBI bad
 eraseblocks limit
In-Reply-To: <1345404079.1930.7.camel@kyv>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
 <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
 <1345404079.1930.7.camel@kyv>
Message-ID: <1345404573.1930.9.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-08-19 at 22:21 +0300, Artem Bityutskiy wrote:
> I'll just remove this from from the defconfig and make it use the
> default, which is more sensible for this device, as your research
> showed.

Actually, pushed this patch to l2-mtd.git:


From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date: Sun, 19 Aug 2012 22:22:23 +0300
Subject: [PATCH] arm: sam9_l9260_defconfig: correct CONFIG_MTD_UBI_BEB_LIMIT

UBI has changed the MTD_UBI_BEB_LIMIT semantics. It used to be a percent of
total amount of eraseblock in the partition, and now it is the maximum
amount of bad eraseblocks on the entire devise per 1024 eraseblocks. So not
only the units changed, but also the meaning.

Richard Genoud <richard.genoud@gmail.com> says:

"I found the board:
https://www.olimex.com/dev/sam9-L9260.html
and the nand datasheet:
http://www.rockbox.org/wiki/pub/Main/LyrePrototype/K9xxG08UXM.pdf
page 11, we can see that the max_bad_bebper1024 is 25 (100 for 4096)"

Thus, use "25" for sam9.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/arm/configs/sam9_l9260_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/sam9_l9260_defconfig b/arch/arm/configs/sam9_l9260_defconfig
index da276f9..b4384af 100644
--- a/arch/arm/configs/sam9_l9260_defconfig
+++ b/arch/arm/configs/sam9_l9260_defconfig
@@ -39,7 +39,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_BEB_LIMIT=3
+CONFIG_MTD_UBI_BEB_LIMIT=25
 CONFIG_MTD_UBI_GLUEBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
1.7.11.2

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120819/ae63b25d/attachment.sig>
