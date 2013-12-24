From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:29:31 +0900
Subject: [PATCH 2/3] sh: sh772[34]: Set serial port sampling rate to 8 for
 SCIFA ports
In-Reply-To: <cover.1387889858.git.horms+renesas@verge.net.au>
References: <cover.1387889858.git.horms+renesas@verge.net.au>
Message-ID: <64c535e942af6cfe59ceceeb9bc6ba5f437a2fc9.1387889858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

SCIFA ports on sh7723 and sh7724 seem to use a sampling rate of half the
value specified in the datasheet. This is currently handled by a custom
baud rate calculation algorithm. The algorithm ID will be removed from
platform data, set the sampling rate directly instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 6 +++---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 521a09e..079951b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -98,7 +98,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.flags          = UPF_BOOT_AUTOCONF,
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
@@ -121,7 +121,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
@@ -144,7 +144,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_REIE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index fb0a237..59c3594 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -365,7 +365,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
@@ -388,7 +388,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
@@ -411,7 +411,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.port_reg	= SCIx_NOT_SUPPORTED,
 	.flags          = UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_RE | SCSCR_TE,
-	.scbrr_algo_id	= SCBRR_ALGO_3,
+	.sampling_rate	= 8,
 	.type           = PORT_SCIFA,
 };
 
-- 
1.8.4
