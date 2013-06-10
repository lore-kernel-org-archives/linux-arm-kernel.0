From: jani@ubuntu.com (Jani Monoses)
Date: Mon, 10 Jun 2013 09:13:05 +0000 (UTC)
Subject: Can switching to FLATMEM cause bugs?
Message-ID: <kp45b0$uue$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

enabling memory control groups in a Nexus 4 kernel causes boot hangs due 
to what I think is a mismatch between where the cgroup code looks for 
memory blocks to account for and physical memory layout of the Nexus 4 
platform. It skips two blocks which are not aligned to 64K which is the 
increment used by memcg initialization code. When later there are 
references to pages in one of these blocks, there's a page fault due to 
invalid cgroup block links.

I found a workaround to be switching to FLATMEM from SPARSEMEM. Could 
this switch cause bugs by itself? I am not sure whether a certain choice 
of memory model is only about best resource utilization and performance 
or it has implications on the correctness of the memory manager.

thanks
Jani

PS: The details of what I think is the bug on the cgroup mailing list 
http://permalink.gmane.org/gmane.linux.kernel.cgroups/7003
