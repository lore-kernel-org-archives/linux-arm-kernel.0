From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Nov 2015 02:25:58 +0800
Subject: [PATCH v10 2/5] missing include in cputime.c, remove #ifdef
 CONFIG_PARAVIRT from sched/core.c
In-Reply-To: <1446567664-11890-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <201511040206.5XWwpMS8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

[auto build test ERROR on arm64/for-next/core]
[cannot apply to: xen-tip/linux-next]
[also ERROR on: v4.3 next-20151103]

url:    https://github.com/0day-ci/linux/commits/Stefano-Stabellini/xen-arm-arm64-CONFIG_PARAVIRT-and-stolen-ticks-accounting/20151104-002433
base:   https://github.com/0day-ci/linux Stefano-Stabellini/xen-arm-arm64-CONFIG_PARAVIRT-and-stolen-ticks-accounting/20151104-002433
config: avr32-atngw100_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=avr32 

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:82:26: error: asm/paravirt.h: No such file or directory
--
>> kernel/sched/cputime.c:8:26: error: asm/paravirt.h: No such file or directory

vim +82 kernel/sched/core.c

52f5684c kernel/sched/core.c Gideon Israel Dsouza  2014-04-07  76  #include <linux/compiler.h>
^1da177e kernel/sched.c      Linus Torvalds        2005-04-16  77  
96f951ed kernel/sched/core.c David Howells         2012-03-28  78  #include <asm/switch_to.h>
5517d86b kernel/sched.c      Eric Dumazet          2007-05-08  79  #include <asm/tlb.h>
838225b4 kernel/sched.c      Satyam Sharma         2007-10-24  80  #include <asm/irq_regs.h>
db7e527d kernel/sched/core.c Christian Borntraeger 2012-01-11  81  #include <asm/mutex.h>
e6e6685a kernel/sched.c      Glauber Costa         2011-07-11 @82  #include <asm/paravirt.h>
^1da177e kernel/sched.c      Linus Torvalds        2005-04-16  83  
029632fb kernel/sched.c      Peter Zijlstra        2011-10-25  84  #include "sched.h"
ea138446 kernel/sched/core.c Tejun Heo             2013-01-18  85  #include "../workqueue_internal.h"

:::::: The code at line 82 was first introduced by commit
:::::: e6e6685accfa81f509fadfc9624bc7c3862d75c4 KVM guest: Steal time accounting

:::::: TO: Glauber Costa <glommer@redhat.com>
:::::: CC: Avi Kivity <avi@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 11783 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/89e802ff/attachment.obj>
