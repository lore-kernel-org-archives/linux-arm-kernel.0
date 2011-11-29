From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Nov 2011 13:30:28 +0000
Subject: [PATCH 4/7] ARM: S3C64XX: Improve logging of unknown Cragganmore
 module types
In-Reply-To: <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <1322573431-8923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1322573431-8923-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As our ID table is populated with hexidecimal values it makes sense to log
unknown module IDs in hexidecimal. It's also helpful to display board
revisions as 1 based rather than 0 based as that's the numbering system
used for the hardware (and what we do when announcing known modules).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 6666856..003c171 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -154,8 +154,8 @@ static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
 					"Failed to register dev: %d\n", ret);
 		}
 	} else {
-		dev_warn(&i2c->dev, "Unknown module ID %d revision %d\n",
-			 id, rev);
+		dev_warn(&i2c->dev, "Unknown module ID 0x%x revision %d\n",
+			 id, rev + 1);
 	}
 
 	return 0;
-- 
1.7.7.3
