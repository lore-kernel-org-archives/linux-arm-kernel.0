From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jul 2016 19:05:33 +0200
Subject: mainline build: 12 warnings 1 failures
 (mainline/v4.7-rc5-284-g6e5c4f1)
In-Reply-To: <5776a052.8408620a.86fce.1d56@mx.google.com>
References: <5776a052.8408620a.86fce.1d56@mx.google.com>
Message-ID: <3687744.RSsK8MoIk0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 1, 2016 9:54:42 AM CEST Olof's autobuilder wrote:
> 
> Warnings:
>       1 drivers/block/floppy.c:1777:44: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:1779:44: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:4487:45: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:4495:45: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:810:44: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:825:43: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/block/floppy.c:826:43: warning: self-comparison always evaluates to true [-Wtautological-compare]
>       1 drivers/infiniband/core/cma.c:1242:12: warning: 'src_addr_storage.sin_addr.s_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 fs/reiserfs/ibalance.c:1156:2: warning: 'new_insert_key' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 include/sound/control.h:219:9: warning: 'master_vol' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       2 drivers/net/wireless/intel/iwlegacy/3945.c:1022:5: warning: suggest explicit braces to avoid ambiguous 'else' [-Wparentheses]


I've added a patch for the first floppy.c warnings to Russell's patch
tracker, I had sent it a while ago to the list and then forgotten about it.

The iwlegacy patch is in linux-next, the other three seem to only show up
in you ppc64 defconfig build. What compiler version do you use there?

	Arnd
