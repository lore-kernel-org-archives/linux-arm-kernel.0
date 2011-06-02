From: linucherian@gmail.com (Linu Cherian)
Date: Thu, 2 Jun 2011 13:41:05 +0530
Subject: Clarification on ARM V6 context switching code
Message-ID: <20110602081105.GA651@T61>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While trying to understand the v6 context switching code, found some
disparity with the code and the architecture specification/TRM. 

Here is my doubt,

1. According to the architecture spec(ARM DDI 0406B), while switching
the ASID, the architecture expects the TTBR to contain ONLY global
mappings except the below cases where we  
-  switch to a reserved context ID 
-  disable the non global mappings

as explained in section "Synchronization of changes of ASID and TTBR. 

In "cpu_v6_switch_mm" function  in arch/arm/mm/proc-v6.S,
we use TTBR0 during the switch which points to process page table
having both global and non global entries. We neither switch to a
reserved context ID nor disable non global mappings. 

This appears to be out of sync with the spec?  

If the above is true, how about using the reserved context id during
the switch ? 

2. In the same function, are we not missing a IMB sequence after
writing to the context ID register as expected by the  the ARM 11
MPCore TRM(ARM DDI 0360F, section  3.4.25 )  ?  


Please point out if i misunderstood the spec/TRM.

Thanks.



-- 
Linu cherian
