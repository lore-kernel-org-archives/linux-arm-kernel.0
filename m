From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jun 2014 16:30:28 +0100
Subject: Dove DT and HDMI on v3.16-rc1
In-Reply-To: <53A1ABE8.8050401@gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com> <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com> <20140618143447.GA22890@arch.cereza>
 <20140618150103.GE32514@n2100.arm.linux.org.uk> <53A1ABE8.8050401@gmail.com>
Message-ID: <20140618153028.GF32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 05:10:32PM +0200, Sebastian Hesselbarth wrote:
> xf86-video-armada needs some missing
> #include "picturestr.h"
> for raring, but whole process has been very straight forward.

I'm only aware of this (sorry, copy'n'pasted) which I found when trying
to build against ubuntu 14.04.  If further patches are needed to make it
compatible with more Xorg versions, please ensure that they find their
way into my inbox...

diff --git a/src/common_drm.h b/src/common_drm.h
index b0c3cd4..3bc5dc6 100644
--- a/src/common_drm.h
+++ b/src/common_drm.h
@@ -1,8 +1,8 @@
 #ifndef COMMON_DRM_H
 #define COMMON_DRM_H
 
-#include "compat-api.h"
 #include "xf86Crtc.h"
+#include "compat-api.h"
 
 struct common_crtc_info {
 	int drm_fd;
diff --git a/src/vivante_unaccel_render.c b/src/vivante_unaccel_render.c
index ad4d5cf..0496d7a 100644
--- a/src/vivante_unaccel_render.c
+++ b/src/vivante_unaccel_render.c
@@ -11,11 +11,11 @@
 #include "config.h"
 #endif
 
-#include "compat-api.h"
 #include "fb.h"
 #include "fbpict.h"
 #include "mipict.h"
 
+#include "compat-api.h"
 #include "vivante_unaccel.h"
 #include "vivante_utils.h"


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
