From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 20 Mar 2012 14:34:04 -0400
Subject: linux-next: "ARM: make mach/io.h include optional" commit breaks
 cm_x2xx_defconfig
Message-ID: <4F68CD9C.3090001@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

If you have a moment can you check this build failure?

http://kisskb.ellerman.id.au/kisskb/buildresult/5923845/

A git bisect seems to want to blame your commit for it.

Thanks,
Paul.

---

c334bc150524f833db3c76a0aaf55fb5044444e1 is the first bad commit
commit c334bc150524f833db3c76a0aaf55fb5044444e1
Author: Rob Herring <rob.herring@calxeda.com>
Date:   Sun Mar 4 22:03:33 2012 -0600

    ARM: make mach/io.h include optional


git bisect start
# good: [fde7d9049e55ab85a390be7f415d74c9f62dd0f9] Linux 3.3-rc7
git bisect good fde7d9049e55ab85a390be7f415d74c9f62dd0f9
# bad: [f355e8684f7e8e7077ca6d3988f24e01047804b6] Add linux-next specific files for 20120320
git bisect bad f355e8684f7e8e7077ca6d3988f24e01047804b6
# good: [5fe35ba6690ea0136d649cb2a07ac3f64a4c3cfb] Merge remote-tracking branch 'sound/for-next'
git bisect good 5fe35ba6690ea0136d649cb2a07ac3f64a4c3cfb
# good: [5260d60f170ebd381538dd56f6f6b765cbf9db29] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 5260d60f170ebd381538dd56f6f6b765cbf9db29
# good: [2eb0aaa70022cbd3cdac7bdb610ed79a3b0c60a7] Merge remote-tracking branch 'writeback/writeback-for-next'
git bisect good 2eb0aaa70022cbd3cdac7bdb610ed79a3b0c60a7
# bad: [da7499ed07635785926c4a12915f54c61dc44170] Merge branch 'next/clk' into for-next
git bisect bad da7499ed07635785926c4a12915f54c61dc44170
# good: [eae71abd0e6d466105c66a40115907335a3e20fa] Merge branch 'next/boards' into for-next
git bisect good eae71abd0e6d466105c66a40115907335a3e20fa
# good: [cdc3df6f44f72c5924a16a47e1663c3fb0e57820] Merge branch 'dt-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/dt
git bisect good cdc3df6f44f72c5924a16a47e1663c3fb0e57820
# good: [f66f9bdf6d2c2b540f73bb57bd24b886b39beb14] Merge branch 'lpc32xx/drivers' into next/drivers
git bisect good f66f9bdf6d2c2b540f73bb57bd24b886b39beb14
# good: [e5412a49eceeab5b9ecb761b536ad7ac829e1c45] Merge branch 'next/dt' into for-next
git bisect good e5412a49eceeab5b9ecb761b536ad7ac829e1c45
# good: [efa497b9ec8cc534f8883a2d1d42f52174070f38] ARM: dove: add explicit include of dove.h to addr-map.c
git bisect good efa497b9ec8cc534f8883a2d1d42f52174070f38
# bad: [accf709b39a9cdbeaf6233000ccb9af966fd691e] Merge branch 'io-cleanup-for-3.4' of git://sources.calxeda.com/kernel/linux into next/cleanup2
git bisect bad accf709b39a9cdbeaf6233000ccb9af966fd691e
# bad: [708795cd975579ba7115666f585c428f8cebd572] Merge branch 'io-cleanup-for-3.4' of git://sources.calxeda.com/kernel/linux into next/cleanup2
git bisect bad 708795cd975579ba7115666f585c428f8cebd572
# bad: [c334bc150524f833db3c76a0aaf55fb5044444e1] ARM: make mach/io.h include optional
git bisect bad c334bc150524f833db3c76a0aaf55fb5044444e1
# good: [41e32c906054be3a600cdeb69eb70350066e0a91] ARM: clps711x: remove unneeded include of mach/io.h
git bisect good 41e32c906054be3a600cdeb69eb70350066e0a91
