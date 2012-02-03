From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:33:50 +0000
Subject: [PATCH 08/17] ARM: sa11x0: neponset: add driver .owner initializer
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOtK-0001C1-Mn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the driver .owner field is properly initialized.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 8fcd542..1beaa0e 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -272,6 +272,7 @@ static struct platform_driver neponset_device_driver = {
 	.resume		= neponset_resume,
 	.driver		= {
 		.name	= "neponset",
+		.owner	= THIS_MODULE,
 	},
 };
 
-- 
1.7.4.4
