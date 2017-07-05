From: joe@perches.com (Joe Perches)
Date: Wed,  5 Jul 2017 13:02:12 -0700
Subject: [PATCH 03/18] ARM: HP Jornada 7XX: Move inline before return type
In-Reply-To: <cover.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Message-ID: <5bd3b2bf39c6c9caf773949f18158f8f5ec08582.1499284835.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert 'u8 inline' to 'inline u8' to be the same style used
by the rest of the kernel.

Miscellanea:

jornada_ssp_reverse is an odd function.
It is declared inline but is also EXPORT_SYMBOL.
It is also apparently only used by jornada720_ssp.c
Likely the EXPORT_SYMBOL could be removed and the function
converted to static.

The addition of static and removal of EXPORT_SYMBOL was not done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-sa1100/jornada720_ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index b143c4659346..7fc11a3c17b4 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -33,7 +33,7 @@ static unsigned long jornada_ssp_flags;
  * we need to reverse all data we receive from the mcu due to its physical location
  * returns : 01110111 -> 11101110
  */
-u8 inline jornada_ssp_reverse(u8 byte)
+inline u8 jornada_ssp_reverse(u8 byte)
 {
 	return
 		((0x80 & byte) >> 7) |
-- 
2.10.0.rc2.1.g053435c
