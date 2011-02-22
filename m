From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 23 Feb 2011 02:29:09 +0300
Subject: [PATCH 1/3] pxa: Enable pxa-pcm-audio on pxa210/pxa25x platform
Message-ID: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa25x platforms were left out of major ASoC Update patch.
Since f0fba2ad1b a registration of pxa-pcm-audio device is required for
ASoC to function on pxa platforms. Register one also for pxa210/pxa25x.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fbc5b77..b166b1d 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -347,6 +347,7 @@ static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_assp,
 	&pxa25x_device_pwm0,
 	&pxa25x_device_pwm1,
+	&pxa_device_asoc_platform,
 };
 
 static struct sys_device pxa25x_sysdev[] = {
-- 
1.7.2.3
