From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Dec 2015 11:38:20 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151203110041.GK8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
Message-ID: <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> On Thu, Dec 03, 2015 at 08:33:13AM +0000, Peter Rosin wrote:
> > I wrote:
> > > If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
> > > following (or very similar) on boot.
> > 
> > I should have said "if I don't disable", as the option is "default y".
> > 
> > Also, if it survives on boot, below is an example of later trouble (after
> > 30+ minutes on this occasion).
> 
> Please apply this patch so we (might) get a slightly better oops dump,
> and then try to reproduce.

Sure thing, but it's still "DAC: 00000051"...

Cheers,
Peter

Unhandled fault: page domain fault (0x81b) at 0x00086578
pgd = c280c000
[00086578] *pgd=22f77831, *pte=2347034f, *ppte=2347083f
Internal error: : 81b [#1] ARM
Modules linked in:
CPU: 0 PID: 904 Comm: ntpd Not tainted 4.3.0+ #30
Hardware name: Atmel SAMA5
task: c39bb500 ti: c2fca000 task.ti: c2fca000
PC is at memcpy+0x50/0x330
LR is at 0x1
pc : [<c01daff0>]    lr : [<00000001>]    psr: 800f0013
sp : c2fcbed4  ip : 00000007  fp : 000d3808
r10: 00000000  r9 : 00000080  r8 : 00000001
r7 : 00000010  r6 : 00000010  r5 : 003f5c28  r4 : 00000000
r3 : 00000002  r2 : ffffffe0  r1 : c2fcbf38  r0 : 00086578
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 2280c059  DAC: 00000051
Process ntpd (pid: 904, stack limit = 0xc2fca208)
Stack: (0xc2fcbed4 to 0xc2fcc000)
bec0:                                              00000000 c2fca000 00000000
bee0: c2fcbf18 00086578 00086578 c01e76c4 c2f77218 c2ff70f4 000d4344 00086578
bf00: 00000000 00000051 0000007c c0010224 c2fca000 c004c988 00000002 00000000
bf20: 003f5c28 00000010 00000010 00000001 00000007 00000001 01f40000 5660283b
bf40: 000ae9dc 00002710 00000000 00000000 00000000 00000000 00000000 00000000
bf60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bf80: 00000000 00000000 00000000 00000000 00000000 00000000 000d3968 0005e38f
bfa0: 000d4344 c0010060 000d3968 0005e38f 00086578 00000000 ffffffff 00000001
bfc0: 000d3968 0005e38f 000d4344 0000007c 000d3814 00000001 000d4338 000d3808
bfe0: 00081e7c bec3e8b4 00026d3d b6ced126 00000030 00086578 8499c1b5 48743d49
[<c01daff0>] (memcpy) from [<c01e76c4>] (__copy_to_user_memcpy+0x138/0x17c)
[<c01e76c4>] (__copy_to_user_memcpy) from [<c004c988>] (SyS_adjtimex+0xd4/0xf0)
[<c004c988>] (SyS_adjtimex) from [<c0010060>] (ret_fast_syscall+0x0/0x3c)
Code: f5d1f05c f5d1f07c e8b151f8 e2522020 (e8a051f8)
---[ end trace bd9256bb17081c58 ]---
