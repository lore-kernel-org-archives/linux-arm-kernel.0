From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 10:59:34 +0100
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code registration
 when DT is enabled
In-Reply-To: <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
Message-ID: <4F967986.6090808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2012 10:54:25 +0100
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code registration when DT is enabled

Now the SCMC911x is correctly enabled in Device Tree, there is no need
to continue registering it from platform code. In fact, if we continue
doing so, the system will throw an error on boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 50809af..9dbd34b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
 	&snowball_led_dev,
 	&snowball_key_dev,
-	&snowball_sbnet_dev,
 	&ab8500_device,
 };
 
-- 
1.7.9.1
