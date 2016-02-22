From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:34 +0100
Subject: [PATCH 0/8] drm: msm: module rework
Message-ID: <1456175331-714117-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I saw some regressions on today's Linux-next kernel after
the Makefiles got reworked and tried to come up with a quick
fix. This ended up taking much longer, but the new version should
be cleaner and I no longer get any build errors in this
driver.

The first two patches are just preparation to avoid the
namespace problems with global symbols and the module name.

The next five patches separate out each subdirectory that has
its own Makefile into a separate loadable module.

The final patch is just a nice addon, it should work in theory
but this needs to be tested well.

	Arnd
