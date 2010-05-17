From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Mon, 17 May 2010 21:09:50 +0200
Subject: PrimeCell interface
In-Reply-To: <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
	<AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A72621C@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan, I think you'd better back out/revert the PrimeCell patches
from your next branch for the time being, i.e. these commits:

ARM: add generic PrimeCell interface to DMA40 v1
ARM: define the PrimeCell DMA API v5

Russell don't want that merged before we can also do it on
the Versatile, and while I'm already far up that road it will
also involve switching to the ioctl()-like API and that
is easier done with a separate patch for that and then
new PrimeCell patches.

Instead, please cherry-pick the DMA40 bug fixes I sent off
earlier, two patches from the latest patch set named:

DMAENGINE: DMA40 bug when checking paused status
DMAENGINE: DMA40 fix for allocation of logical channels

Also the platform data for DMA40 would be nice to feed in
once you have synced in Russells ARM tree.

Yours,
Linus Walleij
