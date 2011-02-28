From: bill_carson@126.com (rocky)
Date: Mon, 28 Feb 2011 21:20:39 +0800 (CST)
Subject: One quick question about SMP on ARM
Message-ID: <4e9f0255.13eed.12e6c6d8194.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I am puzzled these day on three issues for SMP ARM in terms of hardware:
1: Is MMU global or per cpu ?
2: Is MicroTLB/MainTLB global or per cpu ?

I read the code, each cpu has to set its own pgd base addr into TBBR0,so I draw the conclusion MMU is per cpu;
ASID is shared between each cpu, while when ASID rollover from 0xff back to 0x0, each cpu has to call local_flush_tlb_all to invalidate I/D tlb; Does that mean MicroTLB/MainTLB is also per cpu; then why all cpu shared ASID from 0x0~0xff ?


I am really confused about this ? any tips
Thanks

rocky









-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110228/1bab0b01/attachment-0001.html>
