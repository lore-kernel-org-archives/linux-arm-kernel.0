From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 26 Jan 2016 15:37:42 +0800
Subject: Unhandled level 2 translation fault on A72 board.
Message-ID: <56A72246.4050105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone:

I met this problem when running the hackbench test on A72 chip board:

sh[4779]: unhandled level 2 translation fault (11) at 0x7f96be0c80, esr 0x830000
06 
pgd = ffffffc01a1f0000 
[7f96be0c80] *pgd=0000000084a20003, *pud=0000000084a20003, *pmd=0000000000000000

CPU: 1 PID: 4779 Comm: sh Tainted: G O 4.1.15+ #21 
Hardware name: Hisilicon PhosphorHi1382 EVB (DT) 
task: ffffffc0163cc500 ti: ffffffc083abc000 task.ti: ffffffc083abc000 
PC is at 0x7f96be0c80 
LR is at 0x7fb2684eb4 
pc : [<0000007f96be0c80>] lr : [<0000007fb2684eb4>] pstate: 60000000 
sp : 0000007fe9bfc4a0 
x29: 0000007fe9bfc4a0 x28: 0000000000000000 
x27: 0000000000000000 x26: 0000000019834cc8 
x25: 00000000ffffffff x24: 00000000004b8000 
x23: 0000007fe9bfdf39 x22: 0000000019834cc8 
x21: 0000000000000000 x20: 0000000000000005 
x19: 0000007fb27305f0 x18: 0000000000000000 
x17: 0000007fb2684c40 x16: 00000000004b5560 
x15: 0000007fb2807030 x14: 0000007fb25e8084 
x13: ffffffffffffffff x12: 0000000000000020 
x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
x9 : fefefefefefefeff x8 : 0000000000000040 
x7 : 00000000004909b8 x6 : 0000007fe9bfdf39 
x5 : 0000000000000000 x4 : 0000000000000002 
x3 : 0000000000000003 x2 : 0000007fb2732000 
x1 : 0000007fb2730618 x0 : 0000007f96be0c80 

sh[4963]: unhandled level 2 translation fault (11) at 0x00000000, esr 0x92000006
pgd = ffffffc0180c6000 
[00000000] *pgd=0000000015157003, *pud=0000000015157003, *pmd=0000000000000000 

CPU: 0 PID: 4963 Comm: sh Tainted: G O 4.1.15+ #21 
Hardware name: Hisilicon PhosphorHi1382 EVB (DT) 
task: ffffffc0163cb980 ti: ffffffc0840c8000 task.ti: ffffffc0840c8000 
PC is at 0x42c0c8 
LR is at 0x42c03c 
pc : [<000000000042c0c8>] lr : [<000000000042c03c>] pstate: 80000000 
sp : 0000007fcb3d70f0 
x29: 0000007fcb3d7e10 x28: 0000000000000000 
x27: 0000000000000000 x26: 000000003888fcc8 
x25: 00000000ffffffff x24: 00000000004b8000 
x23: 0000000000000000 x22: 0000000038890238 
x21: 000000003888ff20 x20: 0000000000001500 
x19: 0000000000000000 x18: 0000000000000000 
x17: 0000007f88fee630 x16: 00000000004b5d40 
x15: 0000007f89171030 x14: 0000007f88f52084 
x13: ffffffffffffffff x12: 0000000000000020 
x11: 0000007f89098a28 x10: 0000000000000000 
x9 : 0000000000000000 x8 : 0000000000000104 
x7 : 0000007f8909a000 x6 : 0000000000000000 
x5 : 0000000000000000 x4 : 0000000000000000 
x3 : 0000000000000000 x2 : 0000000000000000 
x1 : 0000000000000002 x0 : 000000003888ff20 

????????????????????????????????????

if I run the benchmark only on the core which is in the same cluster, it looks fine and no error happened,
but if I enable the core which in the different cluster, it will happened.

I remember that I met the same problem on the A57 and fix it by enable the [bit6] of the CPUECTLR_EL1 and enable MN,
But this time, I enable the same setting and looks no effort, I have no idea about this problem, does A57 and A72 has
so big difference on TLB?

Thanks for any suggestion.

Ding
