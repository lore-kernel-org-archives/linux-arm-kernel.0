From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Dec 2011 16:49:23 +0000
Subject: [GIT PULL] sa1100 fixes for 3.2
In-Reply-To: <CAN1soZyDCb8BqjTZ3N7kJBspQQtGuBchQYRbr2qcY1J24zCfuw@mail.gmail.com>
References: <CAN1soZyDCb8BqjTZ3N7kJBspQQtGuBchQYRbr2qcY1J24zCfuw@mail.gmail.com>
Message-ID: <201112081649.23956.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Haojian Zhuang wrote:
> The following changes since commit 56f54e7d671969da13693e5a147438f2cc50ca9b:
> 
>   Merge branch 'fix' of git://github.com/ycmiao/pxa-linux into fixes
> (2011-11-23 20:30:08 +0000)

Pulled, thanks! Note that generally, I'd prefer pull requests to be based
on an -rc release instead of my own fixes branch, but it's not a big
deal.

I've also applied the two bug fixes for your pxa gpio series on top of the
branch I already had. It took me a while to figure out that those are not
for 3.2 but instead on the other branch. Since they are obviously required,
I applied them directly (I've noticed the same bug before).

I'm a bit confused about who I should be pulling from pxa and mmp stuff
in general. I've taken the liberal approach so far and just pulled whatever
gets thrown at me as long as it looks good from each of you, but the
MAINTAINERS file currently lists:

PXA2xx/PXA3xx SUPPORT
M:      Eric Miao <eric.y.miao@gmail.com>
M:      Russell King <linux@arm.linux.org.uk>
PXA168 SUPPORT
M:      Eric Miao <eric.y.miao@gmail.com>
M:      Jason Chagas <jason.chagas@marvell.com>
PXA910 SUPPORT
M:      Eric Miao <eric.y.miao@gmail.com>
MMP2 SUPPORT (aka ARMADA610)
M:      Haojian Zhuang <haojian.zhuang@marvell.com>
M:      Eric Miao <eric.y.miao@gmail.com>

Should that be updated to include you for all of these? I certainly don't
want to step on Eric's and Russell's toes but you seem to be doing the bulk
of the pxa/mmp work nowadays and I would prefer to pull from someone
who is actually listed as maintainer.

	Arnd
