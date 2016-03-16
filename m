From: lkp@intel.com (kbuild test robot)
Date: Thu, 17 Mar 2016 02:46:39 +0800
Subject: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <201603170242.mBPNtopO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

[auto build test ERROR on tile/master]
[also build test ERROR on v4.5]
[cannot apply to next-20160316]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Chris-Metcalf/improvements-to-the-nmi_backtrace-code/20160317-010929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git master
config: xtensa-common_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   kernel/built-in.o: In function `SyS_setgroups':
>> (.text+0x16688): undefined reference to `__cpuidle_text_start'
   kernel/built-in.o: In function `SyS_setgroups':
>> (.text+0x1668c): undefined reference to `__cpuidle_text_end'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 9752 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/0d784310/attachment-0001.obj>
