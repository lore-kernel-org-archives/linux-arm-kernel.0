From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 13 Jan 2011 05:58:01 +0800
Subject: mmaping a fixed address fails on ARM
Message-ID: <AANLkTin0jjxLTWzkLHnJ+sGQz=jdDDL94R9o1gh-rO9P@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Andre posted a mmap testcase [1] and a bug report [2] for Ubuntu
kernel on OMAP4 system, since he is porting some applications from x86
to ARM. He testcase works fine on x86, but always fail on ARM. I've
tested it on OMAP3/OMAP4/i.MX51.

Basically what he want to do is get a mapping on a specific virtual
address. But AFAIK, mmap doesn't make sure we can get the mapping
address as we want. On x86, it works fine. So if this fails, the
application can't run on ARM.

The implementation of arch_get_unmapped_area() is different from ARM
and x86, that might makes mmap behavior different between ARM and x86.
Andre said 2.6.28-versatile. I'm not sure whether it is a regression.

[1]: http://launchpadlibrarian.net/61588086/main.c
[2]: https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/697004

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
