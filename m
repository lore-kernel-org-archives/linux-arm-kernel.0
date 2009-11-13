From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 13 Nov 2009 23:53:18 +0000
Subject: [PATCH] Update Samsung S5PC100 SoC support
In-Reply-To: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091113235317.GY4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:21:44AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
> core has been extended with new clocks hierarchy implementation, gpio lib,
> support for external and gpio interrupts and some basics of power
> management (cpu idle and system reset). Also platform helpers for
> s3c framebuffer, i2c and hsmmc drivers has been added.

As such, a new branch git://git.fluff.org/bjdooks/linux next-s5pc1xx
has been created. This branch hasn't yet been build tested, or had the
patches that failed to apply on them.

The following from the series still need fixups before applying due to
the missing FB updates:

Applying: ARM: S5PC1xx: add platform helpers for SDHCI host controllers
Applying: ARM: S5PC1xx: add platform helpers for i2c adapter devices

I'll look at fixing these up tomorrow if the FB items haven't been sorted
out.

The shortlog is:

Kyungmin Park (9):
      ARM: SMDKC100: enable S3C FrameBuffer
      ARM: S5PC1XX: registers rename
      ARM: S5PC1XX: clock registers rename
      ARM: S5PC1XX: clocks reimplementation
      ARM: S5PC1XX: add GPIO L banks to register definition
      ARM: S5PC1XX: GPIO registers rename
      ARM: S5PC1XX: add cpu idle and system reset support
      ARM: SMDKC100: add I2C0 and I2C1 buses support
      ARM: SMDKC100: add SDHCI controllers 0, 1 and 2 support

If there are any problems, please let me know as soon as possible, as I
will be looking to merge these into my main next branch in the next day or
so to begin the final stages of the device and clock reworks.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
