From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 Jan 2012 00:26:41 -0800
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
 <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
Message-ID: <20120109082640.GI22134@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 05:21:02PM -0800, Olof Johansson wrote:

> Mark, Kukjin, can either of you split out the fixes in a separate branch?

Here's some of them, there were a few others I'm aware of that depended
on feature updates.  Ideally we'd actually get all the changes that have
been in -next in.

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git fixes/samsung

Mark Brown (5):
      ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx platforms
      ARM: S3C64XX: Correct reservation of GPIOs for CPU module on Cragganmore
      ARM: SAMSUNG: Guard against multiple inclusion of plat/dma.h
      ARM: SAMSUNG: dma-ops.h needs mach/dma.h
      ARM: SAMSUNG: Declare struct platform_device in plat/s3c64xx-spi.h

 arch/arm/mach-s3c64xx/Kconfig                    |    6 +++---
 arch/arm/mach-s3c64xx/include/mach/crag6410.h    |    3 ++-
 arch/arm/mach-s3c64xx/mach-crag6410.c            |    2 +-
 arch/arm/plat-samsung/Kconfig                    |    8 ++++++++
 arch/arm/plat-samsung/include/plat/dma-ops.h     |    1 +
 arch/arm/plat-samsung/include/plat/dma.h         |    6 +++++-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 ++
 7 files changed, 22 insertions(+), 6 deletions(-)
