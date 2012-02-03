From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:55:34 +0000
Subject: [PATCH 03/20] ARM: sa1111: add sa1111 core driver .owner initializer
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPEM-00043g-Up@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an initializer for the struct device_driver .owner member.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index f0d9faa..957f6e3 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1064,6 +1064,7 @@ static struct platform_driver sa1111_device_driver = {
 	.resume		= sa1111_resume,
 	.driver		= {
 		.name	= "sa1111",
+		.owner	= THIS_MODULE,
 	},
 };
 
-- 
1.7.4.4
