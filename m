From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:10 -0700
Subject: [PATCH 19/34] davinci: DM365: Allow use of GPIO64_57
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-20-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Koeller <thomas.koeller@baslerweb.com>

Extended the MUX configuration to allow use of GPIO
terminals 64..57.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm365.c            |    1 +
 arch/arm/mach-davinci/include/mach/mux.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 871be5a..1ee3fc8 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -576,6 +576,7 @@ MUX_CFG(DM365,	SPI4_SDENA1,	4,   16,    3,    2,	 false)
 MUX_CFG(DM365,	GPIO20,		3,   21,    3,    0,	 false)
 MUX_CFG(DM365,	GPIO33,		4,   12,    3,	  0,	 false)
 MUX_CFG(DM365,	GPIO40,		4,   26,    3,	  0,	 false)
+MUX_CFG(DM365,	GPIO64_57,	2,   6,     1,	  0,	 false)
 
 MUX_CFG(DM365,	VOUT_FIELD,	1,   18,    3,	  1,	 false)
 MUX_CFG(DM365,	VOUT_FIELD_G81,	1,   18,    3,	  0,	 false)
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 8638903..923debe 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -291,6 +291,7 @@ enum davinci_dm365_index {
 	DM365_GPIO20,
 	DM365_GPIO33,
 	DM365_GPIO40,
+	DM365_GPIO64_57,
 
 	/* Video */
 	DM365_VOUT_FIELD,
-- 
1.7.0.2
