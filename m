From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 12 Apr 2012 21:22:31 -0400
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
Message-ID: <20120413012230.GA30438@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

The commit in linux-next:

-----------------
commit b2bc9e0ee349db84035d8141e85babc7986594d7
Author: Mark Brown <broonie@sirena.org.uk>
Date:   Mon Apr 2 12:30:35 2012 +0100

    ARM: 7366/1: amba: Remove AMBA level regulator support
-----------------

is pointed at by git bisect for the u8500_defconfig build failure:

drivers/dma/ste_dma40.c:2708:3: error: implicit declaration of function
'regulator_disable' [-Werror=implicit-function-declaration]
drivers/dma/ste_dma40.c:2747:3: error: implicit declaration of function
'regulator_enable' [-Werror=implicit-function-declaration]
drivers/dma/ste_dma40.c:3260:3: error: implicit declaration of function
'regulator_get' [-Werror=implicit-function-declaration]
drivers/dma/ste_dma40.c:3271:4: error: implicit declaration of function
'regulator_put' [-Werror=implicit-function-declaration]

http://kisskb.ellerman.id.au/kisskb/buildresult/6095691/

If, like my earlier mail this week, this is something you've already
fixed, then please provide me a link, and I'll gladly include that in
the triage report, so you don't get needless extra mails about it.

Thanks,
Paul.
--

git bisect start
# good: [0034102808e0dbbf3a2394b82b1bb40b5778de9e] Linux 3.4-rc2
git bisect good 0034102808e0dbbf3a2394b82b1bb40b5778de9e
# bad: [87487c4514a94892ce478dc012da6d12a98ae360] Add linux-next specific files for 20120412
git bisect bad 87487c4514a94892ce478dc012da6d12a98ae360
# bad: [45701d47f211d6ce72ee2c1725904d2e173eb29f] Merge remote-tracking branch 'sound/for-next'
git bisect bad 45701d47f211d6ce72ee2c1725904d2e173eb29f
# good: [5d2acf8cc7515129a5d3aed7b0e0be18dbcf524f] Merge branch 'topic/misc' into for-next
git bisect good 5d2acf8cc7515129a5d3aed7b0e0be18dbcf524f
# bad: [846c4b315b6faae8f5ede661d80c222d669adbda] Merge remote-tracking branch 'target-merge/for-next-merge'
git bisect bad 846c4b315b6faae8f5ede661d80c222d669adbda
# bad: [9235a323f99492120565935040b6be61e687d0c6] Merge remote-tracking branch 'gfs2/master'
git bisect bad 9235a323f99492120565935040b6be61e687d0c6
# bad: [6c944bb0c84fa1a03af503e926d7bd3a4a7e7376] Merge remote-tracking branch 'usb.current/usb-linus'
git bisect bad 6c944bb0c84fa1a03af503e926d7bd3a4a7e7376
# bad: [ef75674b6700ad96cac1e1c377cf9809cea6a369] Merge remote-tracking branch 'net/master'
git bisect bad ef75674b6700ad96cac1e1c377cf9809cea6a369
# good: [39f86a608a3e0f0164bd1540acf87696cfdfb5bb] Merge branch 'v4l_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 39f86a608a3e0f0164bd1540acf87696cfdfb5bb
# good: [a1ada086062101533eb0f841d3884137688091ec] Merge tag 'sound-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good a1ada086062101533eb0f841d3884137688091ec
# good: [87151b8689d890dfb495081f7be9b9e257f7a2df] net: allow pskb_expand_head() to get maximum tailroom
git bisect good 87151b8689d890dfb495081f7be9b9e257f7a2df
# good: [f549e088b806f44b6ab6eeef0cb71ced1d2488dd] Merge tag 'rdma-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband
git bisect good f549e088b806f44b6ab6eeef0cb71ced1d2488dd
# bad: [b2bc9e0ee349db84035d8141e85babc7986594d7] ARM: 7366/1: amba: Remove AMBA level regulator support
git bisect bad b2bc9e0ee349db84035d8141e85babc7986594d7
# good: [34af657916332e89564566bc8d35e3e06cc0c236] ARM: 7377/1: vic: re-read status register before dispatching each IRQ handler
git bisect good 34af657916332e89564566bc8d35e3e06cc0c236
