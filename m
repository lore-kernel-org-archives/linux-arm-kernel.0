From: ijc@hellion.org.uk (Ian Campbell)
Date: Sun, 26 Feb 2012 11:00:38 +0000
Subject: [PATCH 0/2 v5] arm: kirkwood: add dreamplug/devicetree support
In-Reply-To: <cover.1330025976.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1330025976.git.jason@lakedaemon.net>
Message-ID: <1330254038.10008.24.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-23 at 19:52 +0000, Jason Cooper wrote:
> This patch series provides initial support for devicetree on kirkwood for the
> dreamplug platform.  After discussing the approach with Arnd Bergman last week
> at ELC, we decided to take an incremental approach to the conversion.  First, I
> would detect that we were on the dreamplug via the devicetree blob.  Then,
> configure uart0 via devicetree.  We chose the uart since it is already well
> supported under devicetree.
> 
> This patch series has been boot-tested on the dreamplug.

Tested-by: Ian Campbell <ijc@hellion.org.uk>

I needed the following (obvious) patch against u-boot:

diff --git a/include/configs/dreamplug.h b/include/configs/dreamplug.h
index 0f2f9a2..76f9eea 100644
--- a/include/configs/dreamplug.h
+++ b/include/configs/dreamplug.h
@@ -148,4 +148,6 @@
  */
 #define CONFIG_DISPLAY_CPUINFO
 
+#define CONFIG_OF_LIBFDT
+
 #endif /* _CONFIG_DREAMPLUG_H */


Ian.
