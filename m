From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 9 Jan 2015 18:22:36 +0800
Subject: [PATCH] pinctrl: pass -DDEBUG in subdirs
In-Reply-To: <1420796506-10402-1-git-send-email-linus.walleij@linaro.org>
References: <1420796506-10402-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1420798956.23114.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2015-01-09 at 10:41 +0100, Linus Walleij wrote:
> When drivers are compiled in subdirectories the -DDEBUG flag need
> to be passed in the individual Makefiles.

Hi,

It will be easy to forget adding this when adding new subdirectories.
Can we do this instead?

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index af365c5..36f1d620 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -1,6 +1,6 @@
 # generic pinmux support

-ccflags-$(CONFIG_DEBUG_PINCTRL)        += -DDEBUG
+subdir-ccflags-$(CONFIG_DEBUG_PINCTRL) += -DDEBUG

Joe.C
