From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 05 Mar 2013 21:43:42 +0100
Subject: [PATCH] arm64: Do not select GENERIC_HARDIRQS_NO_DEPRECATED
Message-ID: <1362516222.16460.121.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Config option GENERIC_HARDIRQS_NO_DEPRECATED was removed in commit
78c89825649a9a5ed526c507603196f467d781a5 ("genirq: Remove the now obsolete
config options and select statements"), but the select was accidentally
reintroduced in commit 8c2c3df31e3b87cb5348e48776c366ebd1dc5a7a ("arm64:
Build infrastructure").

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) Commit explanation inspired by commit
2c7d1644406748d7c5da7b9db3c5080296af55bf ("sparc: Do not select
GENERIC_HARDIRQS_NO_DEPRECATED").

 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd70a68..9b6d19f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -9,7 +9,6 @@ config ARM64
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-- 
1.7.11.7
