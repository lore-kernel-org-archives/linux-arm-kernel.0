From: renjithg@tataelxsi.co.in (Renjith G)
Date: Tue, 13 Jan 2015 13:10:42 +0530
Subject: Linux kernel boot up on ARMv7l based board - failed
Message-ID: <54B4CBFA.70006@tataelxsi.co.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have an R-Car H2 development board (Lager) from Renesas and it was 
correctly running with Linux Kernel 3.4.81-ltsi till last week.

But unfortunately now, During boot up the kernel hangs and shows till 
"Starting kernel....."

I have enabled earlyprintk and here is the code flow till freeze point.
1. It is reaching till '/arch/arm/mm/mmu.c' in function 
'devicemaps_init()' and then it calls 'local_flush_tlb_all()'
2. The 'local_flush_tlb_all()' is defined in 
'/arch/arm/include/asm/tlbflush.h' and from there it calls 
'tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", zero);'
3. The above call hangs and hence not returning, so it the boot up hangs.

Do you have any suggestions?

Is this due to any board failure? If so, is there any ways I can tweak it?

I see in step 2, executes some co-processor specific instructions and 
the board has ARM CA9 , ARM CA15 and SH4A processors mentioned in the 
reference manual and I am not so sure.

Expecting your reply.

Many kind regards,
/renjith_g
