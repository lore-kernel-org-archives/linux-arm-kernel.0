From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 18:47:37 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912041222040.31174@xanadu.home>
References: <4B18F141.7070101@denx.de>
	<alpine.LFD.2.00.0912041222040.31174@xanadu.home>
Message-ID: <4B194B39.50301@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas Pitre,

Nicolas Pitre wrote:
> On Fri, 4 Dec 2009, Heiko Schocher wrote:
> 
>> Hello,
>>
>> I have the following shared mem problem on a ARM v5TE
>> processor using Linux version 2.6.28,
> 
> Could you apply this patch and test again:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=08e445bd6a

Thanks for your reply. I applied this patch, but it didn;t help.
Same output as without it:

-bash-3.2# cat shtest2.sh
#!/bin/sh
echo "Run shmtest2"
./shmtest2 write 1 &
./shmtest2 read 4 &

-bash-3.2# ./shtest2.sh
Run shmtest2
Write to in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Write Thread 0, addr:40961000
358: write new mesg: 0
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Creating thread 1
Shared memory Id:0
attach shared mem:41170000
Start Read Thread addr:41170000
Creating thread 2
Shared memory Id:0
attach shared mem:4197f000
Start Read Thread addr:4197f000
Creating thread 3
Shared memory Id:0
attach shared mem:4218e000
Start Read Thread addr:4218e000
-bash-3.2# 358: write new mesg: 0
360 Read from entry in_msg=1000, out_msg=0, addr=40961000
360 Read from entry in_msg=2000, out_msg=0, addr=41170000
360 Read from entry in_msg=3000, out_msg=0, addr=4197f000
360 Read from entry in_msg=4000, out_msg=0, addr=4218e000
358: write new mesg: 1000
360 Read from entry in_msg=5000, out_msg=0, addr=40961000
360 Read from entry in_msg=6000, out_msg=0, addr=41170000
360 Read from entry in_msg=7000, out_msg=0, addr=4197f000
360 Read from entry in_msg=8000, out_msg=0, addr=4218e000
358: write new mesg: 2000
360 Read from entry in_msg=9000, out_msg=0, addr=40961000
360 Read from entry in_msg=10000, out_msg=0, addr=41170000
360 Read from entry in_msg=11000, out_msg=0, addr=4197f000
360 Read from entry in_msg=12000, out_msg=0, addr=4218e000
358: write new mesg: 3000
360 Read from entry in_msg=13000, out_msg=0, addr=40961000
360 Read from entry in_msg=14000, out_msg=0, addr=41170000
360 Read from entry in_msg=15000, out_msg=0, addr=4197f000
360 Read from entry in_msg=16000, out_msg=0, addr=4218e000
358: write new mesg: 4000
360 Read from entry in_msg=17000, out_msg=0, addr=40961000
360 Read from entry in_msg=18000, out_msg=0, addr=41170000
360 Read from entry in_msg=19000, out_msg=0, addr=4197f000
360 Read from entry in_msg=20000, out_msg=0, addr=4218e000
358: write new mesg: 5000

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
