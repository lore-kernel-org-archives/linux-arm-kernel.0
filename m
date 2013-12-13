From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 13 Dec 2013 18:23:44 +0100
Subject: [PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files
In-Reply-To: <201312131717.25435.arnd@arndb.de>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>
 <1386945188-8316-2-git-send-email-jonas.jensen@gmail.com>
 <201312131717.25435.arnd@arndb.de>
Message-ID: <CACmBeS0Uz+Z=MsqvXburO1swCdyGvEXHhfs8M7ZnMMKBNJjG1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2013 17:17, Arnd Bergmann <arnd@arndb.de> wrote:
> IIRC the separate defconfig is needed because we have never gotten a mixed fa526+arm9
> kernel to boot, right? In theory it is supposed to work and there is most likely just
> a small bug somewhere. Once that is working, we can think about adding a generic
> multi_v4_v5_defconfig that handles all multipltform capable platforms along the lines
> of multi_v7_defconfig.

A mixed kernel can boot without panic (tested today).

The panic is avoided when CONFIG_ARM_THUMB=y is removed.

See thread "[PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option":

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219004.html


> I've been out of the loop a bit here. I initially suggested having the restart
> handler be part of the watchdog driver, and I thought you had done that in an
> earlier version. What has changed your mind?

I got the impression from Guenter Roeck's review, that it doesn't belong there,
maybe I was too quick to remove it?

See thread "[PATCH] watchdog: Add MOXA ART watchdog driver":

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183065.html


Thanks,
Jonas
