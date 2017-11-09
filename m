From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Nov 2017 14:00:37 +0000
Subject: next/master boot: 264 boots: 62 failed, 199 passed with 3
 conflicts (next-20171109)
In-Reply-To: <5a0446a2.85a8500a.55819.1c58@mx.google.com>
References: <5a0446a2.85a8500a.55819.1c58@mx.google.com>
Message-ID: <20171109140037.q2fcxmnocgux77xf@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 04:14:26AM -0800, kernelci.org bot wrote:

The armada-8040-db has been failing to boot for a little while in -next,
though there were some generic arm64 issues which make it hard to tell
when it started:

>     defconfig:
>         armada-8040-db:
>             lab-free-electrons: failing since 5 days (last pass: next-20170929 - first fail: next-20171103)

It gets timeouts talking to MMC and a RCU lockup:

[   23.071083] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   23.076772] 	0-...0: (0 ticks this GP) idle=caa/1/4611686018427387904 softirq=408/408 fqs=2281 
[   23.085505] 	(detected by 1, t=5252 jiffies, g=-201, c=-202, q=20)
[   23.091714] Task dump for CPU 0:
[   23.094955] kworker/0:1     R  running task        0    75      2 0x00000002
[   23.102048] Workqueue: events deferred_probe_work_func
[   23.107208] Call trace:
[   23.109668]  __switch_to+0x90/0xa8
[   23.113084]  0xffff8001f5c95c38

with substantially less chat in the log from PCI than mainline where it
seems to boot OK.  Links to some builds for mainline and other useful
information here:

   https://kernelci.org/boot/id/5a040fe359b514c1601cdd1c/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/d5f12d6a/attachment.sig>
