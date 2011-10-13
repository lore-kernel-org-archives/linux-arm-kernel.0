From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 18:03:21 -0700
Subject: [PATCH] [RESEND]  ARM: tegra: devices.c should include devices.h
Message-ID: <1318467801-12184-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolves lots of sparse warnings:

arch/arm/mach-tegra/devices.c:102:24: warning: symbol 'tegra_i2c_device1' was not declared. Should it be static?
arch/arm/mach-tegra/devices.c:112:24: warning: symbol 'tegra_i2c_device2' was not declared. Should it be static?
arch/arm/mach-tegra/devices.c:122:24: warning: symbol 'tegra_i2c_device3' was not declared. Should it be static?
arch/arm/mach-tegra/devices.c:132:24: warning: symbol 'tegra_i2c_device4' was not declared. Should it be static?
[...]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

One of these days I will learn to not typo on the mailing list addresses
for git send-email. Sigh.

 arch/arm/mach-tegra/devices.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index 240d5dc..7a2a02d 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -29,7 +29,9 @@
 #include <mach/iomap.h>
 #include <mach/dma.h>
 #include <mach/usb_phy.h>
+
 #include "gpio-names.h"
+#include "devices.h"
 
 static struct resource gpio_resource[] = {
 	[0] = {
-- 
1.7.4.1
