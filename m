From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 15 Feb 2015 16:10:46 +0100
Subject: Occasional crash in APM xgene enet driver
Message-ID: <20150215151046.GA8034@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For a while now, I've been seeing occasional crashes in the ethernet
driver when running mainline on the APM X-Gene systems.

I've seen this with mainline since somewhere in v3.17 and on several
hardware boards stress testing KVM by running workloads in VMs.

Alex Bennee (cc'ed) is also seeing this from time to time.

Here is one of the crashes, I can begin collecting more if that helps.
Let me know if we can help in other ways to trace down the issue.

Config is defconfig + CONFIG_BRIDGE=y.

Thanks,
-Christoffer

---

Unable to handle kernel NULL pointer dereference at virtual address 000000c0
pgd = ffffffc3e639a000
[000000c0] *pgd=00000043e629d003, *pud=00000043e629d003, *pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6643 Comm: qemu-system-aar Not tainted 3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
task: ffffffc3ee3aee00 ti: ffffffc3c044c000 task.ti: ffffffc3c044c000
PC is at xgene_enet_process_ring+0x94/0x328
LR is at xgene_enet_process_ring+0x78/0x328
pc : [<ffffffc0003f9058>] lr : [<ffffffc0003f903c>] pstate: 80000145
sp : ffffffc3c044fa00
x29: ffffffc3c044fa00 x28: ffffffc0fe8aa218
x27: 0000000000000000 x26: 0000000000000000
x25: ffffffc3ee2b7000 x24: 0000000000000040
x23: ffffffc0fe8aa418 x22: 00000000000001ff
x21: 0000000000000001 x20: ffffffc0ff058380
x19: 000000000000001c x18: 0000007f82d1c1f0
x17: 0000007f84afbc90 x16: ffffffc0001a6a8c
x15: 0000007f84b805a0 x14: 0000000000000000
x13: 00000000d0d03820 x12: 0000000000000000
x11: 0000000000000024 x10: 00000000d0d30a20
x9 : ffffffc00031da28 x8 : ffffffbdc0000000
x7 : ffffffc3cae0285e x6 : 00000040fec00000
x5 : 0c08100801400148 x4 : 00000040ff000000
x3 : 00020000000000d1 x2 : 0000000000000066
x1 : 00000043cae0285e x0 : ffffffc3ee2bb818

Process qemu-system-aar (pid: 6643, stack limit = 0xffffffc3c044c058)
Stack: (0xffffffc3c044fa00 to 0xffffffc3c0450000)
fa00: c044fa70 ffffffc3 003f93d0 ffffffc0 fe8aa290 ffffffc0 00000000 00000000
fa20: 00000040 00000000 0078e000 ffffffc0 0016cac3 00000001 c044fb20 ffffffc3
fa40: ff7d4000 00000003 007825c0 ffffffc0 0000012c 00000000 fff565c0 ffffffc3
fa60: ffffffc0 00000000 ee2b7000 ffffffc3 c044faa0 ffffffc3 004a5cec ffffffc0
fa80: fe8aa290 ffffffc0 00000000 00000000 00000040 00000000 84b805a0 0000007f
faa0: c044fb40 ffffffc3 000b5da0 ffffffc0 c044c000 ffffffc3 0078e000 ffffffc0
fac0: 0077faa0 ffffffc0 c044fb40 ffffffc3 00000018 00000000 00000101 00000000
fae0: 00000003 00000000 0078e0c0 ffffffc0 0078e0d8 ffffffc0 00000000 00000000
fb00: 00000008 00000000 006fbd90 ffffffc0 006fb9f0 ffffffc0 007e3d74 ffffffc0
fb20: c044fb20 ffffffc3 c044fb20 ffffffc3 c044fb30 ffffffc3 c044fb30 ffffffc3
fb40: c044fbc0 ffffffc3 000b6134 ffffffc0 00780000 ffffffc0 00000000 00000000
fb60: 00000000 00000000 00002010 ffffff80 60000145 00000000 00000000 00000000
fb80: 0000011a 00000000 0000001d 00000000 0079e000 ffffffc0 c044c000 ffffffc3
fba0: 0000000a 00000000 0016cac2 00000001 00570c08 ffffffc0 084040c0 0000000a
fbc0: c044fbe0 ffffffc3 000ecb2c ffffffc0 00780000 ffffffc0 000ecafc ffffffc0
fbe0: c044fc20 ffffffc3 00082420 ffffffc0 00797000 ffffffc0 c044fc50 ffffffc3
fc00: 0000200c ffffff80 000fc014 ffffffc0 ee010000 ffffffc3 000a253c 0000005c
fc20: c044fd70 ffffffc3 00085da8 ffffffc0 00000000 00000000 fd024c90 ffffffc0
fc40: c044fd70 ffffffc3 000d0938 ffffffc0 fd024c98 ffffffc0 ee3aee00 ffffffc3
fc60: 00000000 00000000 00000000 00000000 0000ae80 00000000 00000000 00000000
fc80: 00000000 00000000 c7e8ed00 5df42439 0000001d 00000000 00920000 00000000
fca0: ffffffff 00000000 0000001b 00000000 00000000 00000000 00920000 00000000
fcc0: 00000000 00000000 84b805a0 0000007f 001a6a8c ffffffc0 84afbc90 0000007f
fce0: 82d1c1f0 0000007f 00000000 00000000 fd024c90 ffffffc0 00000000 00000000
fd00: feabe300 ffffffc0 0000ae80 00000000 00000000 00000000 0000011a 00000000
fd20: 0000001d 00000000 0079e000 ffffffc0 c044c000 ffffffc3 c044fd70 ffffffc3
fd40: 0009c1d0 ffffffc0 c044fd70 ffffffc3 000d0938 ffffffc0 60000145 00000000
fd60: c044fd70 ffffffc3 0009c1a4 ffffffc0 c044fda0 ffffffc3 0009c2e0 ffffffc0
fd80: feabe300 ffffffc0 fd024c90 ffffffc0 0079e000 ffffffc0 c044c000 00000000
fda0: c044fe10 ffffffc3 001a6824 ffffffc0 feabe300 ffffffc0 00000000 00000000
fdc0: edc06f70 ffffffc3 0000000b 00000000 0000ae80 00000000 00000015 00000000
fde0: 0000011a 00000000 00000040 0000ae80 c044fe20 ffffffc3 0019772c ffffffc0
fe00: edb30000 ffffffc3 00000001 00000000 c044fe90 ffffffc3 001a6b10 ffffffc0
fe20: 00000000 00000000 feabe301 ffffffc0 feabe300 ffffffc0 00000000 00000000
fe40: c044fe70 ffffffc3 001b0a2c ffffffc0 00000000 00000000 ed3ea300 ffffffc3
fe60: c044fe80 0000000b feabe300 ffffffc0 c044fe80 ffffffc3 001b0a80 ffffffc0
fe80: c044fe90 ffffffc3 001a6acc ffffffc0 82d1c600 0000007f 00086430 ffffffc0
fea0: 00000000 00000000 15b1cea0 00000000 ffffffff ffffffff 84afbc9c 0000007f
fec0: 60000000 00000000 00000015 00000000 0000000b 00000000 0000ae80 00000000
fee0: 00000000 00000000 ffffff80 00000000 82d1c700 0000007f 00000001 00000000
ff00: 00000000 00000000 c7e8ed00 5df42439 0000001d 00000000 00920000 00000000
ff20: ffffffff 00000000 0000001b 00000000 00000000 00000000 00920000 00000000
ff40: 00000000 00000000 84b805a0 0000007f 008bc3d0 00000000 84afbc90 0000007f
ff60: 82d1c1f0 0000007f 00920000 00000000 15b1cea0 00000000 00000000 00000000
ff80: 00000001 00000000 84baa000 0000007f 82d1d090 0000007f 15b2512c 00000000
ffa0: 837076f0 0000007f 00800000 00000000 84baf000 0000007f 82d1c600 0000007f
ffc0: 004545a0 00000000 82d1c600 0000007f 84afbc9c 0000007f 60000000 00000000
ffe0: 0000000b 00000000 0000001d 00000000 00000000 00000000 00000000 00000000
Call trace:
[<ffffffc0003f9058>] xgene_enet_process_ring+0x94/0x328
[<ffffffc0003f93cc>] xgene_enet_napi+0x1c/0x54
[<ffffffc0004a5ce8>] net_rx_action+0x1dc/0x2b8
[<ffffffc0000b5d9c>] __do_softirq+0x100/0x220
[<ffffffc0000b6130>] irq_exit+0x90/0xd0
[<ffffffc0000ecb28>] __handle_domain_irq+0x60/0xac
[<ffffffc00008241c>] gic_handle_irq+0x30/0x80
Exception stack(0xffffffc3c044fc30 to 0xffffffc3c044fd50)
fc20:                                     00000000 00000000 fd024c90 ffffffc0
fc40: c044fd70 ffffffc3 000d0938 ffffffc0 fd024c98 ffffffc0 ee3aee00 ffffffc3
fc60: 00000000 00000000 00000000 00000000 0000ae80 00000000 00000000 00000000
fc80: 00000000 00000000 c7e8ed00 5df42439 0000001d 00000000 00920000 00000000
fca0: ffffffff 00000000 0000001b 00000000 00000000 00000000 00920000 00000000
fcc0: 00000000 00000000 84b805a0 0000007f 001a6a8c ffffffc0 84afbc90 0000007f
fce0: 82d1c1f0 0000007f 00000000 00000000 fd024c90 ffffffc0 00000000 00000000
fd00: feabe300 ffffffc0 0000ae80 00000000 00000000 00000000 0000011a 00000000
fd20: 0000001d 00000000 0079e000 ffffffc0 c044c000 ffffffc3 c044fd70 ffffffc3
fd40: 0009c1d0 ffffffc0 c044fd70 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc00009c2dc>] kvm_vcpu_ioctl+0x54/0x6f8
[<ffffffc0001a6820>] do_vfs_ioctl+0x378/0x5e4
[<ffffffc0001a6b0c>] SyS_ioctl+0x80/0x98
Code: f1000b5f f863581b 54001348 79401e82 (f9406360)
---[ end trace 65548354a1e73544 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU6: stopping
CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee16be40 to 0xffffffc3ee16bf60)
be40: ee168000 ffffffc3 007945d0 ffffffc0 ee16bf80 ffffffc3 00087108 ffffffc0
be60: 00000000 00000000 00000000 00000000 fffa1b1c ffffffc3 fffa1b1c ffffffc3
be80: 00000020 00000000 0ccccccd 00000000 a7ea326e 002208f8 fffa1c88 ffffffc3
bea0: ee14bc40 ffffffc3 ee16bd90 ffffffc3 54df86d6 00000000 0008d1b1 00000000
bec0: 00000018 00000000 e8000000 00000003 00000000 00000000 37ea326e 0022731c
bee0: 0010e164 ffffffc0 a9b20c84 0000007f dc507870 0000007f ee168000 ffffffc3
bf00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
bf20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
bf40: 00000000 00000080 ee16bf80 ffffffc3 00087104 ffffffc0 ee16bf80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee153e40 to 0xffffffc3ee153f60)
3e40: ee150000 ffffffc3 007945d0 ffffffc0 ee153f80 ffffffc3 00087108 ffffffc0
3e60: 00000000 00000000 00000000 00000000 fff6db1c ffffffc3 00000001 00000000
3e80: 00000008 00000000 00000010 00000000 fff6e060 ffffffc3 fff6dc88 ffffffc3
3ea0: ee149040 ffffffc3 ee153d90 ffffffc3 000003ff 00000000 b5193519 00000033
3ec0: 56000000 00000000 00000000 00000000 00000000 00000000 98334438 0000007f
3ee0: 440c0400 000000ff 00085000 ffffffc0 00000000 00000000 ee150000 ffffffc3
3f00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
3f20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
3f40: 00000000 00000080 ee153f80 ffffffc3 00087104 ffffffc0 ee153f80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU4: stopping
CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee15be40 to 0xffffffc3ee15bf60)
be40: ee158000 ffffffc3 007945d0 ffffffc0 ee15bf80 ffffffc3 00087108 ffffffc0
be60: 00000000 00000000 00000000 00000000 fff87b1c ffffffc3 0046dda0 ffffffc0
be80: 00000020 00000000 0ccccccd 00000000 a7ea326e 00364cf5 fff87c88 ffffffc3
bea0: ee14a640 ffffffc3 ee15bd90 ffffffc3 000003ff 00000000 b5193519 00000033
bec0: 56000000 00000000 00000000 00000000 00000000 00000000 0071eac8 00000000
bee0: 440c0400 000000ff 00085000 ffffffc0 00000000 00000000 ee158000 ffffffc3
bf00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
bf20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
bf40: 00000000 00000080 ee15bf80 ffffffc3 00087104 ffffffc0 ee15bf80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU5: stopping
CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee15fe40 to 0xffffffc3ee15ff60)
fe40: ee15c000 ffffffc3 007945d0 ffffffc0 ee15ff80 ffffffc3 00087108 ffffffc0
fe60: 00000000 00000000 00000000 00000000 fff94b1c ffffffc3 0046dda0 ffffffc0
fe80: 00000020 00000000 0ccccccd 00000000 a7ea326e 00364cf5 fff94c88 ffffffc3
fea0: ee14b140 ffffffc3 ee15fd90 ffffffc3 000003ff 00000000 b5193519 00000033
fec0: 56000000 00000000 00000000 00000000 00000000 00000000 a4f652e0 0000007f
fee0: 440c0400 000000ff 00085000 ffffffc0 00000000 00000000 ee15c000 ffffffc3
ff00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
ff20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
ff40: 00000000 00000080 ee15ff80 ffffffc3 00087104 ffffffc0 ee15ff80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee147e40 to 0xffffffc3ee147f60)
7e40: ee144000 ffffffc3 007945d0 ffffffc0 ee147f80 ffffffc3 00087108 ffffffc0
7e60: 00000000 00000000 00000000 00000000 fff60b1c ffffffc3 007a7840 ffffffc0
7e80: ee147f00 ffffffc3 ff7e1000 00000003 27ea326e 003816b9 fff62798 ffffffc3
7ea0: ee148540 ffffffc3 ee147d90 ffffffc3 54df86d6 00000000 000e84ba 00000000
7ec0: 00000018 00000000 e8000000 00000003 00000000 00000000 97ea326e 0038b676
7ee0: 0010e164 ffffffc0 86528280 0000007f 8525d920 0000007f ee144000 ffffffc3
7f00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
7f20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
7f40: 00000000 00000080 ee147f80 ffffffc3 00087104 ffffffc0 ee147f80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU7: stopping
CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee16fe40 to 0xffffffc3ee16ff60)
fe40: ee16c000 ffffffc3 007945d0 ffffffc0 ee16ff80 ffffffc3 00087108 ffffffc0
fe60: 00000000 00000000 00000000 00000000 fffaeb1c ffffffc3 0046dda0 ffffffc0
fe80: 00000020 00000000 0ccccccd 00000000 27ea326e 003816b9 fffaec88 ffffffc3
fea0: ee14c740 ffffffc3 ee16fd90 ffffffc3 000003ff 00000000 00000005 00000000
fec0: 005715fc ffffffc0 00000012 00000000 006ce888 ffffffc0 00000000 00000000
fee0: 00000220 00000000 008bc420 00000000 87ffe440 0000007d ee16c000 ffffffc3
ff00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
ff20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
ff40: 00000000 00000080 ee16ff80 ffffffc3 00087104 ffffffc0 ee16ff80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D        3.19.0-rc7+ #254
Hardware name: APM X-Gene Mustang board (DT)
Call trace:
[<ffffffc00008a01c>] dump_backtrace+0x0/0x124
[<ffffffc00008a150>] show_stack+0x10/0x1c
[<ffffffc00055f350>] dump_stack+0x80/0xc4
[<ffffffc000092e74>] handle_IPI+0x184/0x194
[<ffffffc000082464>] gic_handle_irq+0x78/0x80
Exception stack(0xffffffc3ee157e40 to 0xffffffc3ee157f60)
7e40: ee154000 ffffffc3 007945d0 ffffffc0 ee157f80 ffffffc3 00087108 ffffffc0
7e60: 00000000 00000000 00000000 00000000 fff7ab1c ffffffc3 0046dda0 ffffffc0
7e80: 00000020 00000000 0ccccccd 00000000 27ea326e 001584a0 fff7ac88 ffffffc3
7ea0: ee1dd038 ffffffc3 0000000b 00000000 00000000 00000000 00000040 00000000
7ec0: 00000018 00000000 ab20b4ae ffffffff 84000000 002429ba 00000000 003b9aca
7ee0: 001a8064 ffffffc0 ac9bc410 0000007f f9cdda11 00000000 ee154000 ffffffc3
7f00: 007945d0 ffffffc0 00794654 ffffffc0 00570920 ffffffc0 007e3beb ffffffc0
7f20: 006b1598 ffffffc0 00816000 00000040 00818000 00000040 000826e0 ffffffc0
7f40: 00000000 00000080 ee157f80 ffffffc3 00087104 ffffffc0 ee157f80 ffffffc3
[<ffffffc000085da4>] el1_irq+0x64/0xd8
[<ffffffc0000e3df4>] cpu_startup_entry+0xdc/0x12c
[<ffffffc000092944>] secondary_start_kernel+0x114/0x124
---[ end Kernel panic - not syncing: Fatal exception in interrupt
