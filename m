From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:29 +0100
Subject: [PATCH 9/9] docs: drm: remove no longer relevant TODO entry
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-10-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This entry asked to rename all drm core "*_reference/_unrefence"
functions to "*_get/_put".

Now that this task is complete, we can remove this entry from the TODO
list.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 77c2b3c25565..85433af65442 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -28,23 +28,6 @@ them, but also all the virtual ones used by KVM, so everyone qualifies).
 
 Contact: Daniel Vetter, Thierry Reding, respective driver maintainers
 
-Switch from reference/unreference to get/put
---------------------------------------------
-
-For some reason DRM core uses ``reference``/``unreference`` suffixes for
-refcounting functions, but kernel uses ``get``/``put`` (e.g.
-``kref_get``/``put()``). It would be good to switch over for consistency, and
-it's shorter. Needs to be done in 3 steps for each pair of functions:
-
-* Create new ``get``/``put`` functions, define the old names as compatibility
-  wrappers
-* Switch over each file/driver using a cocci-generated spatch.
-* Once all users of the old names are gone, remove them.
-
-This way drivers/patches in the progress of getting merged won't break.
-
-Contact: Daniel Vetter
-
 Convert existing KMS drivers to atomic modesetting
 --------------------------------------------------
 
-- 
2.19.1
