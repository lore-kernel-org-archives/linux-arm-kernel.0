From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Jun 2016 07:46:46 +0800
Subject: [PATCH net-next 1/3] arm64: bpf: implement bpf_tail_call() helper
In-Reply-To: <1465077630-633-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <201606050700.BLJUHUk2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Zi-Shen-Lim/arm64-bpf-implement-bpf_tail_call-helper/20160605-060435
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/net/bpf_jit_comp.c:21:0:
   include/linux/bpf.h: In function 'bpf_prog_get':
>> include/linux/bpf.h:235:9: error: implicit declaration of function 'ERR_PTR' [-Werror=implicit-function-declaration]
     return ERR_PTR(-EOPNOTSUPP);
            ^
   include/linux/bpf.h:235:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/rwsem.h:17:0,
                    from include/linux/mm_types.h:10,
                    from include/linux/sched.h:27,
                    from arch/arm64/include/asm/compat.h:25,
                    from arch/arm64/include/asm/stat.h:23,
                    from include/linux/stat.h:5,
                    from include/linux/compat.h:12,
                    from include/linux/filter.h:10,
                    from arch/arm64/net/bpf_jit_comp.c:22:
   include/linux/err.h: At top level:
>> include/linux/err.h:23:35: error: conflicting types for 'ERR_PTR'
    static inline void * __must_check ERR_PTR(long error)
                                      ^
   In file included from arch/arm64/net/bpf_jit_comp.c:21:0:
   include/linux/bpf.h:235:9: note: previous implicit declaration of 'ERR_PTR' was here
     return ERR_PTR(-EOPNOTSUPP);
            ^
   cc1: some warnings being treated as errors

vim +/ERR_PTR +235 include/linux/bpf.h

0fc174de Daniel Borkmann 2015-03-01  229  static inline void bpf_register_prog_type(struct bpf_prog_type_list *tl)
0fc174de Daniel Borkmann 2015-03-01  230  {
0fc174de Daniel Borkmann 2015-03-01  231  }
0fc174de Daniel Borkmann 2015-03-01  232  
0fc174de Daniel Borkmann 2015-03-01  233  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
0fc174de Daniel Borkmann 2015-03-01  234  {
0fc174de Daniel Borkmann 2015-03-01 @235  	return ERR_PTR(-EOPNOTSUPP);
0fc174de Daniel Borkmann 2015-03-01  236  }
0fc174de Daniel Borkmann 2015-03-01  237  
0fc174de Daniel Borkmann 2015-03-01  238  static inline void bpf_prog_put(struct bpf_prog *prog)

:::::: The code at line 235 was first introduced by commit
:::::: 0fc174dea54546e2b1146e1197da1b6d4bc48107 ebpf: make internal bpf API independent of CONFIG_BPF_SYSCALL ifdefs

:::::: TO: Daniel Borkmann <daniel@iogearbox.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160605/5911aca3/attachment-0001.obj>
