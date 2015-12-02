From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 13:36:26 +0000
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
Message-ID: <20151202133626.c5d9729eb0ffa811fb1ebe8e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in
arch/arm/mach-pxa/palmz72.c, arch/arm/mach-pxa/palmtreo.c and
arch/arm/mach-pxa/mioa701.c between commit 4c25c5d2985c1 ("ARM:
pxa: make more mach/*.h files local") from the arm-soc tree and commit a71daaa10ec2e325f ("[media] move media platform data to
linux/platform_data/media") from the v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

diff --cc arch/arm/mach-pxa/mioa701.c
index a315f6e3c4a6,ccfd2b63c6a4..000000000000
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@@ -52,9 -52,9 +52,9 @@@
  #include <linux/platform_data/keypad-pxa27x.h>
  #include <linux/platform_data/video-pxafb.h>
  #include <linux/platform_data/mmc-pxamci.h>
 -#include <mach/udc.h>
 -#include <mach/pxa27x-udc.h>
 +#include "udc.h"
 +#include "pxa27x-udc.h"
- #include <linux/platform_data/camera-pxa.h>
+ #include <linux/platform_data/media/camera-pxa.h>
  #include <mach/audio.h>
  #include <mach/smemc.h>
  #include <media/soc_camera.h>
diff --cc arch/arm/mach-pxa/palmtreo.c
index b2aae54bed42,2dc56062fb7e..000000000000
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@@ -43,8 -43,8 +43,8 @@@
  #include <linux/platform_data/usb-ohci-pxa27x.h>
  #include <mach/pxa2xx-regs.h>
  #include <linux/platform_data/asoc-palm27x.h>
- #include <linux/platform_data/camera-pxa.h>
+ #include <linux/platform_data/media/camera-pxa.h>
 -#include <mach/palm27x.h>
 +#include "palm27x.h"
  
  #include <sound/pxa2xx-lib.h>
  
diff --cc arch/arm/mach-pxa/palmz72.c
index abba86f3e254,e3df17a7e8d4..000000000000
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@@ -44,12 -44,12 +44,12 @@@
  #include <linux/platform_data/video-pxafb.h>
  #include <linux/platform_data/irda-pxaficp.h>
  #include <linux/platform_data/keypad-pxa27x.h>
 -#include <mach/udc.h>
 +#include "udc.h"
  #include <linux/platform_data/asoc-palm27x.h>
 -#include <mach/palm27x.h>
 +#include "palm27x.h"
  
 -#include <mach/pm.h>
 +#include "pm.h"
- #include <linux/platform_data/camera-pxa.h>
+ #include <linux/platform_data/media/camera-pxa.h>
  
  #include <media/soc_camera.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/b60da1fc/attachment.sig>
