From: prasadsodagudi@gmail.com (prasad sodagudi)
Date: Fri, 4 Jan 2013 18:35:32 +0530
Subject: Would like to store the CPU context of prev and next tasks in the
 function __switch_to()
Message-ID: <CA+tyz+6SVD9=Qc2VYAZMbA7hbu8bHmui-WbAcBjpEf2Z0P57Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Would like to store the previous and next tasks CPU contexts in a specific
location for snooping the task context information.

This would help me to debug  from RAM contents when cpu hang cases.



ENTRY(__switch_to)
 UNWIND(.fnstart        )
 UNWIND(.cantunwind     )
        add     ip, r1, #TI_CPU_SAVE
        ldr     r3, [r2, #TI_TP_VALUE]
 ARM(   stmia   ip!, {r4 - sl, fp, sp, lr} )    @ Store most regs on stack
< code >

Could you please share any code reference for this ?

-Thanks, Prasad
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130104/2b63361c/attachment-0001.html>
