From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 06 Oct 2014 11:06:57 +0200
Subject: [PATCH 0/4] Remove optional dependencies on PLAT_S5P
Message-ID: <1412586417.4054.38.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d78c16ccde96 ("ARM: SAMSUNG: Remove remaining legacy code")
removed the Kconfig symbol PLAT_S5P. The seven dependencies on that
symbol have evaluated to false since next-20140716 (for linux-next) and
v3.17-rc1 (for mainline). Probably no one noticed because these are all
optional dependencies.

I've mentioned this a few times:
- http://lkml.kernel.org/r/1405505756.4408.24.camel at x220
- http://lkml.kernel.org/r/1409825817.5546.99.camel at x220
- http://lkml.kernel.org/r/1411068565.2017.83.camel at x220

As far as I know no fix for this is pending. So let's remove these
optional dependencies. If it turns out that they should actually be
replaced by another symbol, as was said in a reply to my first message
but never done, this series can be used as a reference for the places
that need fixing.

This series is done on top of next-20141003. It is tested by grepping
the tree only.

Paul Bolle (4):
  [media] Remove optional dependencies on PLAT_S5P
  [media] exynos4-is: Remove optional dependency on PLAT_S5P
  [media] Remove optional dependency on PLAT_S5P
  usb: host: Remove optional dependencies on PLAT_S5P

 drivers/media/platform/Kconfig            | 6 +++---
 drivers/media/platform/exynos4-is/Kconfig | 2 +-
 drivers/media/platform/s5p-tv/Kconfig     | 2 +-
 drivers/usb/host/Kconfig                  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.9.3
