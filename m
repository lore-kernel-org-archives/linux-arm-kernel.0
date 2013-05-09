From: yefremov.denis@gmail.com (Denis Efremov)
Date: Thu,  9 May 2013 14:36:59 +0400
Subject: [PATCH 21/21] ARM: remove inline marking of EXPORT_SYMBOL functions
In-Reply-To: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
Message-ID: <1368095819-11011-10-git-send-email-yefremov.denis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXPORT_SYMBOL and inline directives are contradictory to each other.
The patch fixes this inconsistency.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
---
 arch/arm/mach-sa1100/jornada720_ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index b143c46..737842c 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -33,7 +33,7 @@ static unsigned long jornada_ssp_flags;
  * we need to reverse all data we receive from the mcu due to its physical location
  * returns : 01110111 -> 11101110
  */
-u8 inline jornada_ssp_reverse(u8 byte)
+u8 jornada_ssp_reverse(u8 byte)
 {
 	return
 		((0x80 & byte) >> 7) |
-- 
1.8.1.4
