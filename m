From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:12 +0000
Subject: [PATCH] ARM: SAMSUNG: Move common headers from plat-s3c to
	plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move common headers from plat-s3c's include/plat directory into plat-samsung.

No need to fix any files, these are still included via <plat/>

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .../include/plat/audio.h                           |    2 +-
 .../include/plat/cpu-freq.h                        |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/cpu.h  |    2 +-
 .../include/plat/debug-macro.S                     |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/devs.h |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/fb.h   |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/pm.h   |    2 +-
 .../include/plat/regs-fb-v4.h                      |    2 +-
 .../include/plat/regs-fb.h                         |    2 +-
 .../include/plat/regs-serial.h                     |    2 +-
 .../include/plat/uncompress.h                      |    2 +-
 .../include/plat/usb-control.h                     |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/audio.h (91%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/cpu-freq.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/cpu.h (97%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/debug-macro.S (96%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/devs.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/fb.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/pm.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-fb-v4.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-fb.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-serial.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/uncompress.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/usb-control.h (95%)

diff --git a/arch/arm/plat-s3c/include/plat/audio.h b/arch/arm/plat-samsung/include/plat/audio.h
similarity index 91%
rename from arch/arm/plat-s3c/include/plat/audio.h
rename to arch/arm/plat-samsung/include/plat/audio.h
index f22d23b..da561da 100644
--- a/arch/arm/plat-s3c/include/plat/audio.h
+++ b/arch/arm/plat-samsung/include/plat/audio.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/audio.h
+/* arch/arm/plat-samsung/include/plat/audio.h
  *
  * Copyright (c) 2009 Samsung Electronics Co. Ltd
  * Author: Jaswinder Singh <jassi.brar@samsung.com>
diff --git a/arch/arm/plat-s3c/include/plat/cpu-freq.h b/arch/arm/plat-samsung/include/plat/cpu-freq.h
similarity index 98%
rename from arch/arm/plat-s3c/include/plat/cpu-freq.h
rename to arch/arm/plat-samsung/include/plat/cpu-freq.h
index 94eb06a..80c4a80 100644
--- a/arch/arm/plat-s3c/include/plat/cpu-freq.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/cpu-freq.h
+/* arch/arm/plat-samsung/include/plat/cpu-freq.h
  *
  * Copyright (c) 2006-2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
similarity index 97%
rename from arch/arm/plat-s3c/include/plat/cpu.h
rename to arch/arm/plat-samsung/include/plat/cpu.h
index 676db94..d316b4a 100644
--- a/arch/arm/plat-s3c/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c/include/plat/cpu.h
+/* linux/arch/arm/plat-samsung/include/plat/cpu.h
  *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c/include/plat/debug-macro.S b/arch/arm/plat-samsung/include/plat/debug-macro.S
similarity index 96%
rename from arch/arm/plat-s3c/include/plat/debug-macro.S
rename to arch/arm/plat-samsung/include/plat/debug-macro.S
index 3634d4e..43ed0ec 100644
--- a/arch/arm/plat-s3c/include/plat/debug-macro.S
+++ b/arch/arm/plat-samsung/include/plat/debug-macro.S
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c/debug-macro.S
+/* arch/arm/plat-samsung/include/plat/debug-macro.S
  *
  * Copyright 2005, 2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
similarity index 98%
rename from arch/arm/plat-s3c/include/plat/devs.h
rename to arch/arm/plat-samsung/include/plat/devs.h
index c6f9b73..0597ffa 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/devs.h
+/* arch/arm/plat-samsung/include/plat/devs.h
  *
  * Copyright (c) 2004 Simtec Electronics
  * Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
similarity index 98%
rename from arch/arm/plat-s3c/include/plat/fb.h
rename to arch/arm/plat-samsung/include/plat/fb.h
index f8db879..ffc01a7 100644
--- a/arch/arm/plat-s3c/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c/include/plat/fb.h
+/* arch/arm/plat-samsung/include/plat/fb.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
similarity index 99%
rename from arch/arm/plat-s3c/include/plat/pm.h
rename to arch/arm/plat-samsung/include/plat/pm.h
index 2543bd2..245836d 100644
--- a/arch/arm/plat-s3c/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/pm.h
+/* arch/arm/plat-samsung/include/plat/pm.h
  *
  * Copyright (c) 2004 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c/include/plat/regs-fb-v4.h b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
similarity index 99%
rename from arch/arm/plat-s3c/include/plat/regs-fb-v4.h
rename to arch/arm/plat-samsung/include/plat/regs-fb-v4.h
index a60ed0d..0f43599 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb-v4.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/regs-fb-v4.h
+/* arch/arm/plat-samsung/include/plat/regs-fb-v4.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
similarity index 99%
rename from arch/arm/plat-s3c/include/plat/regs-fb.h
rename to arch/arm/plat-samsung/include/plat/regs-fb.h
index e9ee599..0ef806e 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/regs-fb.h
+/* arch/arm/plat-samsung/include/plat/regs-fb.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
similarity index 99%
rename from arch/arm/plat-s3c/include/plat/regs-serial.h
rename to arch/arm/plat-samsung/include/plat/regs-serial.h
index 60d6604..a6eba84 100644
--- a/arch/arm/plat-s3c/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-serial.h
+/* arch/arm/plat-samsung/include/plat/regs-serial.h
  *
  *  From linux/include/asm-arm/hardware/serial_s3c2410.h
  *
diff --git a/arch/arm/plat-s3c/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
similarity index 98%
rename from arch/arm/plat-s3c/include/plat/uncompress.h
rename to arch/arm/plat-samsung/include/plat/uncompress.h
index dc66a47..e87ce8f 100644
--- a/arch/arm/plat-s3c/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c/uncompress.h
+/* arch/arm/plat-samsung/include/plat/uncompress.h
  *
  * Copyright 2003, 2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c/include/plat/usb-control.h b/arch/arm/plat-samsung/include/plat/usb-control.h
similarity index 95%
rename from arch/arm/plat-s3c/include/plat/usb-control.h
rename to arch/arm/plat-samsung/include/plat/usb-control.h
index a6a57bf..7fa1fbe 100644
--- a/arch/arm/plat-s3c/include/plat/usb-control.h
+++ b/arch/arm/plat-samsung/include/plat/usb-control.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s3c/include/plat/usb-control.h
+/* arch/arm/plat-samsung/include/plat/usb-control.h
  *
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
-- 
1.6.0.4
