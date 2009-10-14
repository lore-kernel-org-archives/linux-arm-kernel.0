From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 14 Oct 2009 10:46:51 +0200
Subject: [at91sam9g45] Network crash
Message-ID: <4AD58FFB.50204@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

during system performance tests I encountered such an error if creating network traffic either with web browser or other tools. Here output from nuttcp.

# nuttcp -t -T5m 192.168.1.90
nuttcp-t: Info: attempting to switch to deprecated "classic" mode
nuttcp-t: Info: will use less reliable transmitter side statistics
Unable to handle kernel NULL pointer dereference at virtual address 0000001a
pgd = c0004000
[0000001a] *pgd=00000000
Internal error: Oops: 80000000 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.32-rc2 #25)
PC is at 0x1a
LR is at tcp_transmit_skb+0x1d8/0x6c4
pc : [<0000001a>]    lr : [<c0231798>]    psr: 20000033
sp : c0325d30  ip : c3b06480  fp : c3b064e8
r10: 00000020  r9 : 00025d80  r8 : c3bf3c68
r7 : 00000020  r6 : c3bf3c48  r5 : c3b06480  r4 : c0325d38
r3 : 0000001b  r2 : 00000000  r1 : 00000000  r0 : 0000000c
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment kernel
Control: 0005317f  Table: 73894000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0324270)
Stack: (0xc0325d30 to 0xc0326000)
5d20:                                     00000119 00000040 00000002 00000000
5d40: ffffb2b3 0007e2b0 0000001b 00000000 00000406 c3b06480 c3b06480 000005a8
5d60: c3bf3ba0 c3bf3bc0 00025d80 5c1ab86a c3b064e8 c0234254 00000000 00000000
5d80: 00000000 00000000 000005a8 00000000 00000003 0000001d 00000002 ffffb2b3
5da0: c3b064e8 00000402 00000000 c3b06480 00000020 c3845900 c3b06480 00000020
5dc0: c3845920 00000002 c39702f0 c02343fc 00000020 c3b06480 c3b06480 c022f3f4
5de0: c021b7e4 c02198a0 80000013 c3bfc844 00000001 c3b06480 c3845900 c3bfc844
5e00: c3b06480 0000924d c3bfc830 00000002 c39702f0 c0236984 c3845900 c0359f60
5e20: 00000000 00000000 c3845900 c3bfc844 00000000 c3b06480 c3845900 c3bfc844
5e40: 7c01a8c0 c0236f1c 7c01a8c0 0000924d 00000002 00000006 00000006 c3845900
5e60: c0359f60 00000000 00000008 00000080 c0359b70 c021bb78 c3bfc830 c3845900
5e80: c3970000 c021baa0 c3970000 c0029a54 c3bfc822 00000042 c3845900 c0359b50
5ea0: c3970000 00000000 00000008 c02033dc 00000109 c0359b60 c3845900 00000109
5ec0: c3845900 00000042 c39702c0 00000109 ffffffc2 c01bd3d0 c0325f78 00000040
5ee0: 00000001 0000003f 0000004c c39702f0 00000040 0000000c 0000012c c033d224
5f00: c0359b60 ffffb2b5 c033d234 c0203af0 41069265 00000100 c0324000 0000000c
5f20: 00000001 00000003 c03462f8 0000000a 00000000 c0046230 00000001 c032ce18
5f40: 00000019 00000019 00000000 00000019 c0327b20 70023a70 41069265 70023a3c
5f60: 00000000 c002907c c0325fc4 ffffffff fefff000 c0029a54 00000000 0005317f
5f80: 0005217f 60000013 c0324000 c0327b2c c0341590 c0327b20 70023a70 41069265
5fa0: 70023a3c 00000000 600000d3 c0325fc0 c002ae54 c002ae60 60000013 ffffffff
5fc0: c002b368 c002b334 c034ad3c c0341550 c0025e10 c0008ae4 c00085fc 00000000
5fe0: 00000000 c0025e10 00053175 c03415b8 c0026214 70008034 00000000 00000000
Code: bad PC value.
Kernel panic - not syncing: Fatal exception in interrupt
[<c002f6ec>] (unwind_backtrace+0x0/0xdc) from [<c0269648>] (panic+0x34/0x120)
[<c0269648>] (panic+0x34/0x120) from [<c002d9d4>] (die+0x130/0x15c)
[<c002d9d4>] (die+0x130/0x15c) from [<c0030898>] (__do_kernel_fault+0x68/0x80)
[<c0030898>] (__do_kernel_fault+0x68/0x80) from [<c0030a68>] (do_page_fault+0x1b8/0x1d0)
[<c0030a68>] (do_page_fault+0x1b8/0x1d0) from [<c0029b2c>] (__pabt_svc+0x4c/0x80)
[<c0029b2c>] (__pabt_svc+0x4c/0x80) from [<0000001a>] (0x1a)

Kernel version:
# uname -r
2.6.32-rc2

Any idea?

Best regards,
Yegor
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/xml
Size: 38575 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091014/0dca56c5/attachment-0001.xpdl>
