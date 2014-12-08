From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Dec 2014 12:22:35 +0000
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <CA+Ln22EFKRm_9HPaVvL7zFdmmB5Zz5RnJKbZkESVOBOLPvUnGA@mail.gmail.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141205162312.GB11502@n2100.arm.linux.org.uk>
 <CA+Ln22EFKRm_9HPaVvL7zFdmmB5Zz5RnJKbZkESVOBOLPvUnGA@mail.gmail.com>
Message-ID: <20141208122235.GC11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 08:54:18PM +0900, Tomasz Figa wrote:
> 2014-12-06 1:23 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Given where we are in the cycle (-final likely this weekend) the only
> > thing we can do right now is to drop the patch set; exynos (and mvebu)
> > will have to wait another cycle until this patch set (hopefully in a
> > revised form) can be merged.
> 
> Or a fix could be queued on top of this. Since (I believe) this series
> has been queued for 3.19, we have 6 or 7 RC releases ahead, which
> could be used for the purpose of fixing things (as they are supposed
> to?).

They were merged on 27th November, so they would've been in linux-next
from about last Monday.  Nishanth reported a failure on Friday, the
last week day before the merge window opens.  There's no time to try
and fix this before the merge window, which is why I decided to drop
it.  They have already been dropped.  They were dropped immediately
after my message on Friday was sent.  So they've not been in linux-next
over this past weekend.

We don't push known broken code in during the merge window.  The merge
window is the exact time when subtle bugs are likely to be introduced,
and is the exact time that you want bisect to work.  If we push known
broken patches into the kernel during that period, we break the ability
to use bisect to find problems, especially where it causes a platform
to become unbootable.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
