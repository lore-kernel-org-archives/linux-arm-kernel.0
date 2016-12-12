From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 12 Dec 2016 10:34:19 +0100
Subject: Odroid C2 crashes with Bad mode in Error handler detected on CPUx
In-Reply-To: <8587bd84-0135-708b-5cde-67c8a537b111@gmx.de>
References: <8587bd84-0135-708b-5cde-67c8a537b111@gmx.de>
Message-ID: <0d0812c0-ac31-f9a6-e940-ce0e21a26dbd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2016 10:20 PM, Heinrich Schuchardt wrote:
> On Linux-Next 20160812 Hardkernel Ordroid C2 crashes reproducably with
> errors like those listed below.
> 
> Same happened with 4.9.0-rc6-next-20161124
> (cf. https://lkml.org/lkml/2016/11/26/63)
> and v4.9-rc8.
> 
> The errors occur only under heavy CPU load like
> git checkout linux-next
> or building the kernel.
> 
> Could someone, please, give me a hint how to analyze the problem.
> 
> Best regards
> 
> Heinrich Schuchardt
> 
> [  978.592628] CPU: 1 PID: 2240 Comm: git Not tainted
> 4.9.0-rc8-next-20161208-r002-arm64 #1
> [  978.600644] Hardware name: Hardkernel ODROID-C2 (DT)
> [  978.605561] task: ffff800070da7080 task.stack: ffff80007332c000
> [  978.611427] PC is at 0xffff8b9ed958
> [  978.614875] LR is at 0xaaaad12538d0
> [  978.618325] pc : [<0000ffff8b9ed958>] lr : [<0000aaaad12538d0>]
> pstate: 80000000
> [  978.625655] sp : 0000ffffd0ea7c20
> [  978.628934] x29: 0000ffffd0ea7c20 x28: 0000000000000004
> [  978.634194] x27: 0000000000000000 x26: 0000aaaaead52414
> [  978.639455] x25: 0000ffffd0ea7c70 x24: 0000000000000004
> [  978.644717] x23: 0000ffffd0ea7d18 x22: 0000aaaad12b7000
> [  978.649978] x21: 0000000000000004 x20: 0000000000002722
> [  978.655239] x19: 0000000000002722 x18: 00000000000700d9
> [  978.660500] x17: 0000ffff8b9ed980 x16: 0000000000000000
> [  978.665762] x15: 0000000000052332 x14: 0000000000000008
> [  978.671023] x13: 5241574d5249465f x12: 454c55444f4d0a3b
> [  978.676284] x11: 0a3b29445f564552 x10: 5f455241574d5249
> [  978.681545] x9 : 465f353631324953 x8 : 0000000000000040
> [  978.686807] x7 : 465f454c55444f4d x6 : 0a3b29224c504722
> [  978.692068] x5 : 0000aaaad11af1c8 x4 : 0000ffffd0ea7ca0
> [  978.697329] x3 : 0000aaaaeb1189d8 x2 : 0000000000002722
> [  978.702590] x1 : 0000ffffd0ea7d18 x0 : 0000000000002722
> [  978.707851]
> [  978.709329] Internal error: Attempting to execute userspace memory:
> 8600000f [#1] PREEMPT SMP
> [  978.717771] Modules linked in: meson_rng rng_core iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables ipv6 realtek
> [  978.729762] CPU: 1 PID: 2240 Comm: git Not tainted
[...]
> [ 1072.564370] Exception stack(0xffff80007158fcf0 to 0xffff80007158fe20)
> [ 1072.570752] fce0:                                   0000000000000000
> 0001000000000000
> [ 1072.578515] fd00: ffff80007158fec0 0000000000000000 ffff800070fe8aa0
> 0000000000000000
> [ 1072.586278] fd20: 0000000000000004 ffff000008aa9818 ffff800070e31900
> 000000000808540c
> [ 1072.594040] fd40: ffff80007158fd90 ffff0000080c87f8 ffff80007158fe40
> ffff800070e31900
> [ 1072.601803] fd60: 0000000000000004 00000000000003c0 ffff80007158fe40
> 0000000000000000
> [ 1072.609565] fd80: 0000000000000000 0000000000000000 0000000000000000
> ffff800070e31900
> [ 1072.617328] fda0: 000000000000047b 0000000000000003 0000000000000000
> 00000000047b047a
> [ 1072.625090] fdc0: 000000000000047a 0000000000000000 000000000004db59
> ffff80007158fb40
> [ 1072.632853] fde0: 00000000000002e4 0000000000000002 00000000000002e3
> ffff000008b1eacd
> [ 1072.640615] fe00: ffff000088b1eabf 0000000000000006 0000000000000000
> 0000000000000000
> [ 1072.648376] [<          (null)>]           (null)
> [ 1072.653036] Code: bad PC value
> [ 1072.656128] ---[ end trace e838c4fb00307731 ]---

Hi Heinrich,

This is known issue, and I already posted an hack to disable some reserved memory zones at [1]

A patch will be posted for all boards in the next days.

Neil

[1] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001729.html
