From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 18:07:42 +0800
Subject: [PATCH v4 75/79] include/uapi/xen/privcmd.h: fix compilation in
 userspace
In-Reply-To: <1444888618-4506-76-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <201510151821.PnU1OSD3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikko,

[auto build test ERROR on drm/drm-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Mikko-Rapeli/Userspace-compile-test-and-fixes-for-exported-uapi-header-files/20151015-150653
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from drivers/xen/privcmd.c:33:0:
>> include/uapi/xen/privcmd.h:48:23: error: conflicting types for 'xen_pfn_t'
    typedef unsigned long xen_pfn_t;
                          ^
   In file included from arch/arm64/include/asm/xen/interface.h:1:0,
                    from include/xen/interface/xen.h:30,
                    from include/xen/xen.h:23,
                    from arch/arm64/include/asm/io.h:35,
                    from include/linux/bio.h:30,
                    from include/linux/writeback.h:192,
                    from include/linux/memcontrol.h:30,
                    from include/linux/swap.h:8,
                    from drivers/xen/privcmd.c:20:
   arch/arm64/include/../../arm/include/asm/xen/interface.h:39:15: note: previous declaration of 'xen_pfn_t' was here
    typedef __u64 xen_pfn_t;
                  ^

vim +/xen_pfn_t +48 include/uapi/xen/privcmd.h

    42	#endif /* domid_t */
    43	
    44	#ifndef xen_pfn_t
    45	#if (defined __ARMEL__ || defined __ARMEB__)
    46	typedef __u64 xen_pfn_t;
    47	#else
  > 48	typedef unsigned long xen_pfn_t;
    49	#endif /* (defined __ARMEL__ || defined __ARMEB__) */
    50	#endif /* xen_pfn_t */
    51	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45525 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/a5d22f23/attachment-0001.obj>
