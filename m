From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 17 Nov 2015 03:29:20 +0800
Subject: [arm:drm-etnaviv-devel 37/149]
 drivers/staging/etnaviv/etnaviv_gem.c:736:17: error: 'ret' may be used
 uninitialized in this function
Message-ID: <201511170319.Vu9Qo0FA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   77c57a5498ebe5c85b4a71fbcf800a9140f9a697
commit: f24eb15f1158bfe949a40fbfc26d8eb7b13849cf [37/149] staging: etnaviv: add userptr mapping support
config: tile-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f24eb15f1158bfe949a40fbfc26d8eb7b13849cf
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

Note: the arm/drm-etnaviv-devel HEAD 77c57a5498ebe5c85b4a71fbcf800a9140f9a697 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/staging/etnaviv/etnaviv_gem.c: In function 'etnaviv_gem_userptr_do_get_pages':
>> drivers/staging/etnaviv/etnaviv_gem.c:736:17: error: 'ret' may be used uninitialized in this function
   cc1: all warnings being treated as errors

vim +/ret +736 drivers/staging/etnaviv/etnaviv_gem.c

   730		}
   731		up_read(&mm->mmap_sem);
   732	
   733		if (ret < 0) {
   734			release_pages(pvec, pinned, 0);
   735			drm_free_large(pvec);
 > 736			return ERR_PTR(ret);
   737		}
   738	
   739		return pvec;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 41456 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/b73286c5/attachment-0001.obj>
