From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 27 Jun 2015 15:21:52 +0200
Subject: imx: apf27: the board no longer boot with latest git kernel
Message-ID: <558EA370.6020108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've tested the lastest linus git kernel, and this kernel
no longer boot on my armadeus apf27. The last line of the
log are (after, the kernel is stalled) :

[    0.000000] CPU identified as i.MX27, silicon rev 2.1
[    0.000000] Switching to timer-based delay loop, resolution 60ns
[    0.000024] sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 129171917793ns
[    0.008172] clocksource mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 114963006693 ns
[    0.020252] Console: colour dummy device 80x30
[    0.024894] Calibrating delay loop (skipped), value calculated using timer frequency..

I've done a bisect and the commit that raise this issue is :
db2ae4b4f6b79bd11d6461d41bd0966b0006f20b
ARM: imx: provide gpt device specific irq functions

Do you also reproduce this issue please ? or may be I've missed
to enable an new option ?

Regards,
Philippe
