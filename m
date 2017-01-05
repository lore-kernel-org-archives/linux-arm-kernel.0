From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 6 Jan 2017 09:42:30 +1100
Subject: next-20170105 build: 4 failures 3 warnings (next-20170105)
In-Reply-To: <20170105195546.wnmjwh4hazqiyodf@sirena.org.uk>
References: <E1cP6p1-0007i0-IF@optimist>
 <20170105195546.wnmjwh4hazqiyodf@sirena.org.uk>
Message-ID: <20170106094222.234c290b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 5 Jan 2017 19:55:46 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 05, 2017 at 12:07:08PM +0000, Build bot for Mark Brown wrote:
> 
> Since sometime over the Christmas vacation all arm64 configs have been
> failing to build due to:
> 
> > ../arch/arm64/include/asm/setup.h:14:29: error: redefinition of 'kaslr_offset'  
> 
> (same error repeating a different number of times for each config).
> This is an interaction between Andrew's -current tree and Linus' tree.
> Andrew's tree has "arm64: setup: introduce kaslr_offset()"
> (1a339a14b1f2c7 in current -next) and Linus' tree has a commit
> 7ede8665f27cde7d with the same title but a modified version that went to
> Linus through Will.  In the version in Andrew's tree kaslr_offset() is
> defined in asm/setup.h while in the version in Linus' tree it is
> instead defined in asm/memory.h so -next ends up with two definitions of
> that function causing the build errors.
> 
> I guess the commit in Andrew's tree should be dropped now, reverting it
> fixes the builds for me.

OK, I have now dropped the initial part of akpm's -current tree that
was sent to Linus (including the above commit).  Sorry for not noticing
earlier.

Andrew, this means that your tree in linux-next now contains:

a63a9bb7abd2 ipc/sem: add hysteresis
07be42f325e3 ipc/sem.c: avoid using spin_unlock_wait()
6d3a63124caa scripts/gdb: add lx-fdtdump command
138d8657d5ff kdump, vmcoreinfo: report actual value of phys_base
67dbc87b155b lib: Add CRC64 ECMA module
30daa67dc769 mm/vmstat.c: walk the zone in pageblock_nr_pages steps
d5419fdf6ed6 mm/page_owner: align with pageblock_nr pages
6eb902b75775 z3fold: fix locking issues
2fb167a08fa3 z3fold: fix header size related issues
c7f6417f13f6 z3fold: discourage use of pages that weren't compacted
8e40c9ecad02 z3fold: use per-page spinlock
9d759ab4feec mm/z3fold.c: extend compaction function
e22149b524d9 mm/z3fold.c: make pages_nr atomic
cb9a2fb0a835 mm/z3fold.c: limit first_num to the actual range of possible buddy indexes
1411714ceeee mm, page_alloc: avoid page_to_pfn() when merging buddies
794cc4aa50dc mm, page_alloc: don't convert pfn to idx when merging
8c0ff3c42376 mm-throttle-show_mem-from-warn_alloc-fix
e4974bce6cc7 mm: throttle show_mem() from warn_alloc()
4b2de28ffcd0 tmpfs: change shmem_mapping() to test shmem_aops
1143ed06c725 kernel-watchdog-prevent-false-hardlockup-on-overloaded-system-fix
6904a50482ee kernel/watchdog: prevent false hardlockup on overloaded system
04a26c045475 block: restore /proc/partitions to not display non-partitionable removable devices
409d7387f7be ocfs2: fix crash caused by stale lvb with fsdlm plugin
27040ecd9fbb ocfs2-old-mle-put-and-release-after-the-function-dlm_add_migration_mle-called-fix
c19202b8a963 ocfs2: old mle put and release after the function dlm_add_migration_mle called
d82c60f3a069 scripts/spelling.txt: add several more common spelling mistakes
af85e2db2cba arm: arch/arm/include/asm/page.h needs personality.h
3da3cb66bb1b mm/thp/pagecache/collapse: free the pte page table on collapse for thp page cache.
3180061bc2fd mm/thp/pagecache: only withdraw page table after a successful deposit
(merge linux-next - akpm stuff)
4453f4fde106 scripts/spelling.txt: add "followings" pattern and fix typo instances
f1c251fd2f4a scripts/spelling.txt: add "therfore" pattern and fix typo instances
09029516eb46 scripts/spelling.txt: add "overwriten" pattern and fix typo instances
a1d75390cb06 scripts/spelling.txt: add "overwritting" pattern and fix typo instances
174def646afe scripts/spelling.txt: add "deintialize(d)" pattern and fix typo instances
a3475e364975 scripts/spelling.txt: add "disassocation" pattern and fix typo instances
f8fa89870426 scripts/spelling.txt: add "omited" pattern and fix typo instances
a907cffe94c0 scripts/spelling.txt: add "explictely" pattern and fix typo instances
382a878623a8 scripts/spelling.txt: add "applys" pattern and fix typo instances
b349d54c456a scripts/spelling.txt: add "configuartion" pattern and fix typo instances
38bfb6e670f4 scripts/spelling.txt: add "overrided" pattern and fix typo instances
5453cfe4dc41 scripts/spelling.txt: add "overide" pattern and fix typo instances
4ad56706176e scripts/spelling.txt: add "disble(d)" pattern and fix typo instances
342f1c20e5c5 scripts/spelling.txt: add "comsume(r)" pattern and fix typo instances
4787ac5086e0 scripts/spelling.txt: add "intialise(d)" pattern and fix typo instances
46283934f6ae scripts/spelling.txt: add "initialiazation" pattern and fix typo instances
df8e7e0a5bc4 scripts/spelling.txt: add "intialization" pattern and fix typo instances
2f336b08f6f0 scripts/spelling.txt: add "unneded" pattern and fix typo instances
33faac7f1266 scripts/spelling.txt: add "neded" pattern and fix typo instances
c0c9925ac473 scripts/spelling.txt: add "againt" pattern and fix typo instances
f6efcac2efe0 scripts/spelling.txt: add "embeded" pattern and fix typo instances
7590c4f7f34b scripts/spelling.txt: add "varible" pattern and fix typo instances
36b857060ad7 scripts/spelling.txt: add "efective" pattern and fix typo instances
268f025aa99f scripts/spelling.txt: add "algined" pattern and fix typo instances
9fc9398d752e scripts/spelling.txt: add "aligment" pattern and fix typo instances
7b2467807cbc scripts/spelling.txt: add "partiton" pattern and fix typo instances
fea25f1f9e37 scripts/spelling.txt: add "an one" pattern and fix typo instances
84860c6996c9 scripts/spelling.txt: add "an union" pattern and fix typo instances
a9a1e595ac30 scripts/spelling.txt: add "an user" pattern and fix typo instances
4bde980b9c4a scripts/spelling.txt: add "swithc" pattern and fix typo instances
f19ed214ee17 scripts/spelling.txt: add "swith" pattern and fix typo instances
0f401b986050 reimplement-idr-and-ida-using-the-radix-tree-support-storing-null-in-the-idr-checkpatch-fixes
6bfd1dd54e38 idr: support storing NULL in the IDR
9b54b6ba4a61 Reimplement IDR and IDA using the radix tree
6dde86413add fs: add i_blocksize()

-- 
Cheers,
Stephen Rothwell
