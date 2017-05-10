From: yanjiang.jin@windriver.com (yanjiang.jin at windriver.com)
Date: Wed, 10 May 2017 01:13:03 -0400
Subject: [PATCH] socfpga_a10: fix a kexec boot issue
Message-ID: <20170510051304.131042-1-yanjiang.jin@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

I guess socfpga's other boards may need this patch, but I have Arria10
board only. 
So add a new function socfpga_a10_cpu_kill(), keep the old function
socfpga_cpu_kill() for other boards.
I also verified CPU_HOTPLUG after applying this patch, everything seems well.

Test steps:

1. Enable kexec and build a SOCFPGA kernel;
2. Use zImage as 1st and 2nd kernel;
3. kexec -l /root/zImage --append="`cat /proc/cmdline`" 
4. kexec -e

Test env:

U-Boot 2014.10 (Jan 13 2016 - 11:07:09)

CPU   : Altera SOCFPGA Arria 10 Platform
BOARD : Altera SOCFPGA Arria 10 Dev Kit

-- 
1.9.1
