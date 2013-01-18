From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 18 Jan 2013 22:27:26 +0800
Subject: kernel/time/tick-broadcast.c:136:10: error: 'struct
 clock_event_device' has no member named 'evt_handler'
Message-ID: <50f95bce.nUS84hQLN1KYn1xE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvm-prereq-merged
head:   0a9423ee25cf2f3122d7d65d0fc4652eceda3bdb
commit: 0dd9fbd5c510a51ed3d68aa4594a18ebd3a8547d clockevents: Add generic timer broadcast receiver
date:   4 days ago
config: make ARCH=x86_64 allyesconfig

All error/warnings:

   kernel/time/tick-broadcast.c: In function 'tick_receive_broadcast':
>> kernel/time/tick-broadcast.c:136:10: error: 'struct clock_event_device' has no member named 'evt_handler'

vim +136 kernel/time/tick-broadcast.c

   130		struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
   131		struct clock_event_device *evt = td->evtdev;
   132	
   133		if (!evt)
   134			return -ENODEV;
   135	
 > 136		if (!evt->evt_handler)
   137			return -EINVAL;
   138	
   139		evt->event_handler(evt);

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
