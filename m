From: yeasah@comrex.com (Yeasah Pell)
Date: Tue, 01 Dec 2009 17:13:56 -0500
Subject: strange, spurious seeming vector exception on pxa300
Message-ID: <4B159524.2020408@comrex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anybody ever seen vector exceptions happen on an ARM (xscale, 
pxa300) without 26-bit mode being used? I have some application and 
kernel code which appears to work on most hardware, but we have at least 
one board which causes periodic messages:

Unhandled fault: vector exception (0x010) at 0x412c8a90

(I also fudged the fault handler a bit to dump the SPSR: 0x80000010)

These messages correspond with a SEGV being sent to the application. The 
code address is always the same, but the instruction in question is just 
an ordinary load just like many others surrounding it. It's in a hot 
path so it's being run successfully for thousands of iterations before 
the problem manifests. Running in gdb and ignoring the SEGV causes the 
application to continue normally, so apparently the load is successful 
(the particular load operation in question is critical to proper 
operation of the app)

The definition of a vector exception as I understand it seems to be at 
odds with the context in which the exception is being generated (for one 
thing the CPU's not in 26-bit mode, and for another thing the data 
address is nowhere near the exception vectors), so it seems like it 
might be spurious somehow.

If anybody has any theory how this might happen other than some kind of 
hardware fault, please let me know! It's driving me absolutely nuts.

Thanks,
Yeasah Pell
