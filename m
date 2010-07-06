From: rk.raggit@gmail.com (RK Raggit)
Date: Tue, 6 Jul 2010 21:10:58 +0530
Subject: cortex-m3 on linux-2.6.33
Message-ID: <AANLkTikEZcUjmAx7CpMXubH-pj5dSFiOBkw2Uvu7u2o3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

I rebased the baseport of my cortex-m3 board on your latest
linux-2.6-stable git (2.6.33 kernel).
My first observation after booting is that the system appears more
stable now. My earlier baseport
based on 2.6.28 kernel was largely unstable with simple commands
crashing the kernel easily.
My first question -

Q1/ could you please summarise significant changes that you made in
the cortex-m3 architecture
port in the 2.6.33 kernel

Now to an issue i am facing with the latest kernel. When i run command
like "ls -l" or
cat /proc/meminfo in an infinite loop on the shell, after running for
about a minute or so they crash
with a dump like below -

-------------------------------8<8<---------------------------
(ls -l dump)
Unhandled exception: IPSR = 00000003 LR = fffffff1
CPU: 0    Not tainted  (2.6.33-arm1 #6)
PC is at copy_namespaces+0xe/0x8c
LR is@copy_process+0x565/0x904
pc : [<800531d6>]    lr : [<80044fd9>]    psr: 2100000b
sp : 83c20238  ip : 83c42848  fp : 83cf0ac0
r10: 83c44a10  r9 : 00000000  r8 : 00000000
r7 : 83c20248  r6 : 00004111  r5 : 00000010  r4 : 460ad0f9
r3 : 83c77000  r2 : 00000000  r1 : 00000010  r0 : 00004111
--------------------------------------------------------------------
(cat /proc/meminfo dump)
Unhandled exception: IPSR = 00000003 LR = fffffff1
CPU: 0    Not tainted  (2.6.33-arm1 #6)
PC is at do_wait+0xf4/0x124
LR is at __call_rcu+0x31/0xa4
pc : [<800473c8>]    lr : [<8005b841>]    psr: 6100000b
sp : 83c202c8  ip : 0000000c  fp : 00000000
r10: 83c1e108  r9 : 0000018c  r8 : 83c20300
r7 : 83c44c00  r6 : 83c1e000  r5 : 83c20000  r4 : 83c202e8
r3 : 1b478423  r2 : 1b478423  r1 : 00000000  r0 : 0000018c
--------------------------------------------------------------------

I am sure dumps are not due to memory constraint since my system has
ample memory (64MB).

Any thoughts ?

--RK
