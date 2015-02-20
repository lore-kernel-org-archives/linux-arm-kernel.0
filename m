From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 20 Feb 2015 08:43:54 +0000
Subject: Occasional crash in APM xgene enet driver
In-Reply-To: <54E248AE.4060405@redhat.com>
References: <20150215151046.GA8034@cbox> <54E248AE.4060405@redhat.com>
Message-ID: <873861ynud.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Mark Langsdorf <mlangsdo@redhat.com> writes:

> On 02/15/2015 09:10 AM, Christoffer Dall wrote:
>> Hi,
>>
>> For a while now, I've been seeing occasional crashes in the ethernet
>> driver when running mainline on the APM X-Gene systems.
>>
>> I've seen this with mainline since somewhere in v3.17 and on several
>> hardware boards stress testing KVM by running workloads in VMs.
>>
>> Alex Bennee (cc'ed) is also seeing this from time to time.

Here is another one:

Unable to handle kernel NULL pointer dereference at virtual address 00000000.
pgd = ffffffc3ed3d7000.
[00000000] *pgd=0000000000000000, *pud=0000000000000000.
Internal error: Oops: 96000005 [#1] PREEMPT SMP.
Modules linked in:.
CPU: 0 PID: 2241 Comm: tmux Not tainted 3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
task: ffffffc3ec75a100 ti: ffffffc3eb664000 task.ti: ffffffc3eb664000.
PC is at memcpy+0xbc/0x180.
LR is at gro_pull_from_frag0+0x54/0x100.
pc : [<ffffffc00036a2bc>] lr : [<ffffffc00054ebdc>] pstate: 80000145.
sp : ffffffc3eb667b70.
x29: ffffffc3eb667b70 x28: 00000000ffffffff .
x27: ffffffc0ff059bc0 x26: 000000000000000e .
x25: 000000000000000e x24: 0000000000000000 .
x23: 0000000000000680 x22: ffffffc3e24c49c0 .
x21: ffffffc3e24c5040 x20: 0000000000000043 .
x19: ffffffc3eb72ea00 x18: 000000000000000e .
x17: 0000007fa5fc3a04 x16: 0000007fa60eadd0 .
x15: 0007f89c3de72b17 x14: ffffffc0006aa5e0 .
x13: ffff000000000000 x12: ffffffffffffffff .
x11: 0000000000000030 x10: 000000000000003f .
x9 : 0000000000008dc9 x8 : 0000000000000000 .
x7 : ffffffc3e24c4a24 x6 : ffffffc3e24c4a01 .
x5 : ffffffc3e24c4a24 x4 : 0000000000000000 .
x3 : ffffffc3e24c4a10 x2 : ffffffffffffffc3 .
x1 : 0000000000000000 x0 : ffffffc3e24c4a01 .
.
Process tmux (pid: 2241, stack limit = 0xffffffc3eb664058).
Stack: (0xffffffc3eb667b70 to 0xffffffc3eb668000).
7b60:                                     eb667bb0 ffffffc3 005519b0 ffffffc0.
7b80: eb72ea00 ffffffc3 00000003 00000000 eb72ea28 ffffffc3 ece4c290 ffffffc3.
7ba0: 00000000 00000000 00000000 00000000 eb667c10 ffffffc3 00551f34 ffffffc0.
7bc0: ece4c218 ffffffc3 eb72ea00 ffffffc3 ece4c290 ffffffc3 ece4c418 ffffffc3.
7be0: 000001ff 00000000 00000040 00000000 ed2aa000 ffffffc3 eb72ea00 ffffffc3.
7c00: ece4c218 ffffffc3 0090eb58 ffffffc0 eb667c40 ffffffc3 004879d8 ffffffc0.
7c20: ece4c218 ffffffc3 00000004 00000000 000000de 00000000 ffffffff 00000000.
7c40: eb667cc0 ffffffc3 00487ccc ffffffc0 ece4c290 ffffffc3 00000040 00000000.
7c60: eb667d80 ffffffc3 00902000 ffffffc0 002e3583 00000001 fff502c0 ffffffc3.
7c80: 008f62c0 ffffffc0 00902000 ffffffc0 00000000 00000000 ece4c290 ffffffc3.
7ca0: eb667ce0 ffffffc3 003814f8 ffffffc0 0080bd68 ffffffc0 ed2aa000 ffffffc3.
7cc0: eb667cf0 ffffffc3 00552b74 ffffffc0 00000040 00000000 0000012c 00000000.
7ce0: eb667d80 ffffffc3 00552a54 ffffffc0 eb667da0 ffffffc3 000bee58 ffffffc0.
7d00: 00000003 00000000 00000004 00000000 009020d8 ffffffc0 00000008 00000000.
7d20: 00000003 00000000 00973fc8 ffffffc0 00000100 00000000 00902000 ffffffc0.
7d40: 008f2aa0 ffffffc0 007c5a18 ffffffc0 eb667d90 ffffffc3 00826868 ffffffc0.
7d60: 00826440 ffffffc0 00973a63 ffffffc0 ff65a000 00000003 eb667d90 ffffffc3.
7d80: eb667d80 ffffffc3 eb667d80 ffffffc3 eb667d90 ffffffc3 eb667d90 ffffffc3.
7da0: eb667e20 ffffffc3 000bf304 ffffffc0 00000000 00000000 008f4000 ffffffc0.
7dc0: 007c2000 ffffffc0 00830000 ffffffc0 00000000 00000000 00000001 00000000.
7de0: ee010800 ffffffc3 a60ea000 0000007f c62208c0 0000007f eb664000 ffffffc3.
7e00: eb667e20 ffffffc3 002e3582 00000001 00404040 0000000a 008f2aa0 ffffffc0.
7e20: eb667e40 ffffffc3 000fea64 ffffffc0 00000000 00000000 000fea34 ffffffc0.
7e40: eb667ea0 ffffffc3 0008247c ffffffc0 eb667ed0 ffffffc3 0000200c ffffff80.
7e60: 0090bd60 ffffffc0 00002010 ffffff80 20000000 00000000 a60eb000 0000007f.
7e80: e43dbd50 0000007f 00086f14 ffffffc0 0000005c 00000000 eb667ed0 ffffffc3.
7ea0: c6220640 0000007f 00086250 ffffffc0 00000000 00000000 e441a080 0000007f.
7ec0: ffffffff ffffffff a60bae00 0000007f e4419e80 0000007f 00000000 00000000.
7ee0: e4419e80 0000007f 00000000 00000000 a60badc0 0000007f a60770e0 0000007f.
7f00: a615f000 0000007f 00000000 00000000 00000000 00000000 00310e58 00000000.
7f20: 00000000 00000000 00020a65 00000000 00000018 00000000 e8000000 00000003.
7f40: 00000000 00000000 3de72b17 0007f89c a60eadd0 0000007f a5fc3a04 0000007f.
7f60: 0000000e 00000000 e4419e80 0000007f e441a080 0000007f 00000000 00000000.
7f80: 00000008 00000000 00000001 00000000 a60eb000 0000007f e43dbd50 0000007f.
7fa0: a60ea000 0000007f c62208c0 0000007f e4419e90 0000007f c6220640 0000007f.
7fc0: a60bade8 0000007f c6220640 0000007f a60bae00 0000007f 20000000 00000000.
7fe0: e4407110 0000007f ffffffff ffffffff 21313250 24610431 02716208 c6893154.
Call trace:.
[<ffffffc00036a2bc>] memcpy+0xbc/0x180.
[<ffffffc0005519ac>] dev_gro_receive+0x74/0x348.
[<ffffffc000551f30>] napi_gro_receive+0x44/0x154.
[<ffffffc0004879d4>] xgene_enet_process_ring+0x150/0x350.
[<ffffffc000487cc8>] xgene_enet_napi+0x28/0x60.
[<ffffffc000552b70>] net_rx_action+0x144/0x360.
[<ffffffc0000bee54>] __do_softirq+0x120/0x33c.
[<ffffffc0000bf300>] irq_exit+0x9c/0xd0.
[<ffffffc0000fea60>] __handle_domain_irq+0x94/0xfc.
[<ffffffc000082478>] gic_handle_irq+0x38/0x84.
Exception stack(0xffffffc3eb667eb0 to 0xffffffc3eb667fd0).
7ea0:                                     00000000 00000000 e441a080 0000007f.
7ec0: ffffffff ffffffff a60bae00 0000007f e4419e80 0000007f 00000000 00000000.
7ee0: e4419e80 0000007f 00000000 00000000 a60badc0 0000007f a60770e0 0000007f.
7f00: a615f000 0000007f 00000000 00000000 00000000 00000000 00310e58 00000000.
7f20: 00000000 00000000 00020a65 00000000 00000018 00000000 e8000000 00000003.
7f40: 00000000 00000000 3de72b17 0007f89c a60eadd0 0000007f a5fc3a04 0000007f.
7f60: 0000000e 00000000 e4419e80 0000007f e441a080 0000007f 00000000 00000000.
7f80: 00000008 00000000 00000001 00000000 a60eb000 0000007f e43dbd50 0000007f.
7fa0: a60ea000 0000007f c62208c0 0000007f e4419e90 0000007f c6220640 0000007f.
7fc0: a60bade8 0000007f c6220640 0000007f.
Code: 390000c3 d65f03c0 f1020042 5400024a (a8c12027) .
---[ end trace 009860b400ea320e ]---.
Kernel panic - not syncing: Fatal exception in interrupt.
CPU1: stopping.
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee35be20 to 0xffffffc3ee35bf40).
be20: 00000001 00000000 ee358000 ffffffc3 ee35bf60 ffffffc3 000871f8 ffffffc0.
be40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fff5ab1c ffffffc3.
be60: 00000001 00000000 fff5b060 ffffffc3 ef2f4500 00001bd0 ee1bf988 ffffffc0.
be80: ee350540 ffffffc3 ee35bd90 ffffffc3 002e3561 00000001 1ce8b652 00000000.
bea0: 00000018 00000000 ab19d808 ffffffff 20000000 0017b644 00000000 003b9aca.
bec0: 001f17f0 ffffffc0 9108e2fc 0000007f c6d79450 0000007f 00000001 00000000.
bee0: ee358000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
bf00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
bf20: 007c83c8 ffffffc0 ee35bf60 ffffffc3 000871f4 ffffffc0 ee35bf60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU5: stopping.
CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee36be20 to 0xffffffc3ee36bf40).
be20: 00000005 00000000 ee368000 ffffffc3 ee36bf60 ffffffc3 000871f8 ffffffc0.
be40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fff92b1c ffffffc3.
be60: 00000001 00000000 00000000 00000000 00000001 00000000 ed2ffaec ffffffc3.
be80: ee353140 ffffffc3 ee36bd90 ffffffc3 ffffffff 00000000 00000030 00000000.
bea0: 00000003 00000000 00000000 00000000 a2ebfa5c 0000007f a3004590 0000007f.
bec0: 001f17f0 ffffffc0 a2f7c1ec 0000007f ca6a3f00 0000007f 00000005 00000000.
bee0: ee368000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
bf00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
bf20: 007c83c8 ffffffc0 ee36bf60 ffffffc3 000871f4 ffffffc0 ee36bf60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU4: stopping.
CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee367e20 to 0xffffffc3ee367f40).
7e20: 00000004 00000000 ee364000 ffffffc3 ee367f60 ffffffc3 000871f8 ffffffc0.
7e40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fff84b1c ffffffc3.
7e60: 00000001 00000000 00000010 00000000 e3dd1900 00001bd2 fff85060 ffffffc3.
7e80: ee352640 ffffffc3 ee367d90 ffffffc3 002e3522 00000001 0096d350 ffffffc0.
7ea0: ffffff98 ffffffff 00000001 00000000 ffffffff 00000000 801ca590 0000007f.
7ec0: 001e4f34 ffffffc0 80122990 0000007f f72c9740 0000007f 00000004 00000000.
7ee0: ee364000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
7f00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
7f20: 007c83c8 ffffffc0 ee367f60 ffffffc3 000871f4 ffffffc0 ee367f60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU2: stopping.
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee35fe20 to 0xffffffc3ee35ff40).
fe20: 00000002 00000000 ee35c000 ffffffc3 ee35ff60 ffffffc3 000871f8 ffffffc0.
fe40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fff68b1c ffffffc3.
fe60: 00000001 00000000 eb5ef988 ffffffc3 05be9300 00001c0f fff69060 ffffffc3.
fe80: ee351040 ffffffc3 ee35fd90 ffffffc3 00000060 00000000 0e651bd2 00000000.
fea0: 00000078 00000000 00000008 00000000 20000000 0017b644 91116590 0000007f.
fec0: 001ef8cc ffffffc0 91091b00 0000007f 8d17d7a0 0000007f 00000002 00000000.
fee0: ee35c000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
ff00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
ff20: 007c83c8 ffffffc0 ee35ff60 ffffffc3 000871f4 ffffffc0 ee35ff60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU3: stopping.
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee363e20 to 0xffffffc3ee363f40).
3e20: 00000003 00000000 ee360000 ffffffc3 ee363f60 ffffffc3 000871f8 ffffffc0.
3e40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fff76b1c ffffffc3.
3e60: 00000001 00000000 00000010 00000000 57315b80 00001bd0 fff77060 ffffffc3.
3e80: ee351b40 ffffffc3 ee363d90 ffffffc3 002e34c0 00000001 006393a8 ffffffc0.
3ea0: ffffffff ffffffff 00000001 00000000 00000001 00000000 dd319ba0 ffffffc3.
3ec0: 00000220 00000000 00ad5470 00000000 8eb8f270 0000007f 00000003 00000000.
3ee0: ee360000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
3f00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
3f20: 007c83c8 ffffffc0 ee363f60 ffffffc3 000871f4 ffffffc0 ee363f60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU7: stopping.
CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee37be20 to 0xffffffc3ee37bf40).
be20: 00000007 00000000 ee378000 ffffffc3 ee37bf60 ffffffc3 000871f8 ffffffc0.
be40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fffaeb1c ffffffc3.
be60: 00000001 00000000 00000010 00000000 05be9300 00001c0f fffaf060 ffffffc3.
be80: ee354740 ffffffc3 ee37bd90 ffffffc3 000001f2 00000000 006393a8 ffffffc0.
bea0: 00000018 00000000 e8000000 00000003 00000000 00000000 ba7b47cb 00228713.
bec0: 001f17f0 ffffffc0 a5ff11ec 0000007f 0000000e 00000000 00000007 00000000.
bee0: ee378000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
bf00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
bf20: 007c83c8 ffffffc0 ee37bf60 ffffffc3 000871f4 ffffffc0 ee37bf60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
CPU6: stopping.
CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D        3.19.0-ajb-00007-gce7ccbe #89.
Hardware name: APM X-Gene Mustang board (DT).
Call trace:.
[<ffffffc00008ad9c>] dump_backtrace+0x0/0x170.
[<ffffffc00008af2c>] show_stack+0x20/0x2c.
[<ffffffc0006235dc>] dump_stack+0x74/0xc4.
[<ffffffc000094824>] handle_IPI+0x1c8/0x298.
[<ffffffc0000824bc>] gic_handle_irq+0x7c/0x84.
Exception stack(0xffffffc3ee36fe20 to 0xffffffc3ee36ff40).
fe20: 00000006 00000000 ee36c000 ffffffc3 ee36ff60 ffffffc3 000871f8 ffffffc0.
fe40: 000f46e0 ffffffc0 00000000 00000000 007dacf0 ffffffc0 fffa0b1c ffffffc3.
fe60: 00000001 00000000 00000010 00000000 decb9a00 00001bd1 cad7bc98 ffffffc3.
fe80: ee353c40 ffffffc3 ee36fd90 ffffffc3 002e3582 00000001 01c23675 00000000.
fea0: 00000018 00000000 ab19d808 ffffffff 20000000 0017b644 00000000 003b9aca.
fec0: 001f17f0 ffffffc0 9108e2fc 0000007f c6d79450 0000007f 00000006 00000000.
fee0: ee36c000 ffffffc3 009876d0 ffffffc0 00974000 ffffffc0 0090858c ffffffc0.
ff00: 00637000 ffffffc0 00830b10 ffffffc0 009738b2 ffffffc0 00000001 00000000.
ff20: 007c83c8 ffffffc0 ee36ff60 ffffffc3 000871f4 ffffffc0 ee36ff60 ffffffc3.
[<ffffffc000085da4>] el1_irq+0x64/0xd8.
[<ffffffc0000f46dc>] cpu_startup_entry+0x134/0x230.
[<ffffffc00009425c>] secondary_start_kernel+0x114/0x124.
Rebooting in 1 seconds..Reboot failed -- System halted.

>>
>> Here is one of the crashes, I can begin collecting more if that helps.
>> Let me know if we can help in other ways to trace down the issue.
>>
>> Config is defconfig + CONFIG_BRIDGE=y.
>
> This looks like the out of order descriptor bytes read bug
> fixed in:
>
> commit ecf6ba83d76e0c78e89401750dc527008e14faa2
> Author: Iyappan Subramanian <isubramanian@apm.com>
> Date:   Thu Jan 29 14:38:23 2015 -0800
> drivers: net: xgene: fix: Out of order descriptor bytes read
>
> You should update to 3.19 and see if you still see the problem.
> We were seeing it daily until we added that patch and it has
> since gone away.

I guess there are multiple problems as I have that patch in 3.19.

>
> --Mark Langsdorf
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alex Benn?e
