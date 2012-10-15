From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Oct 2012 17:30:27 +0800
Subject: [PATCH v3 1/2] i2c: change id to let i2c-gpio work
In-Reply-To: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1350293428-24551-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c core driver will turn the platform device ID to busnum
When using platfrom device ID as -1, it means dynamically assigned
the busnum. When writing code, we need to make sure the busnum,
and call i2c_register_board_info(int busnum, ...) to register device
if using -1, we do not know the value of busnum
	
In order to solve this issue, set the platform device ID as a fix number
Here using 0 to match the busnum used in i2c_regsiter_board_info()

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change since v2
  Fix this issue for more boards
Change since v1
  Make the commit message more clear
---
 arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index a563189..7cd8053 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -479,7 +479,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91rm9200_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 0f24cfb..805ef95 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -389,7 +389,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9260_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 9752f17..0256a00 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -285,7 +285,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9261_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 8dde220..23b6384 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -567,7 +567,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9263_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index d6ca054..3d2c81d 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -314,7 +314,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9rl_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
-- 
1.7.9.5
