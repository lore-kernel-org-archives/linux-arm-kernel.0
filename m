From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 8 Aug 2017 03:31:48 +0800
Subject: [arm64:for-next/kernel-mode-neon 6/6] ERROR: "kernel_neon_busy"
 [crypto/crypto_simd.ko] undefined!
Message-ID: <201708080336.L3L2uC4U%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/kernel-mode-neon
head:   174dfb12860eac361f3ced9fefb51393fec5bd32
commit: 174dfb12860eac361f3ced9fefb51393fec5bd32 [6/6] arm64: neon: Temporarily add a kernel_mode_begin_partial() definition
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 174dfb12860eac361f3ced9fefb51393fec5bd32
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> ERROR: "kernel_neon_busy" [crypto/crypto_simd.ko] undefined!
>> ERROR: "kernel_neon_busy" [arch/arm64/crypto/sha256-arm64.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/c8fad0f7/attachment-0001.gz>
