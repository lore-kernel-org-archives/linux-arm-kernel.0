From: harninder.rai@nxp.com (Harninder Rai)
Date: Tue, 10 May 2016 12:32:15 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <20160405052341.GA19476@linaro.org>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
Message-ID: <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> This means that there is no enough space left at this point.
> I guess that you are using too big initramfs against 64MB of total memory.
> Just increase the memory size for crash dump kernel.
> 
> -Takahiro AKASHI

Hello Takahiro Akashi,

I used a smaller initramfs (as you suggested) and my crash kernel has moved further but it again dumped with the following log messages. Any further pointers?
Does this mean that there isn't enough memory to save the core file or something? Because the error mostly are related to OOM killer process

[    8.833434] Freeing unused kernel memory: 748K (ffff800000a3a000 - ffff800000af5000)
[    8.848924] init: Console is alive
[    8.856866] mmc0: new high speed SDHC card at address b368
[    8.868239] mmcblk0: mmc0:b368 SDC   3.75 GiB
[    8.873913]  mmcblk0: p1
[    9.855930] init: - preinit -
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[   12.896779] procd: - early -
[   12.977417] kworker/u16:0 invoked oom-killer: gfp_mask=0x27000c0, order=2, oom_score_adj=0
[   12.994568] CPU: 0 PID: 6 Comm: kworker/u16:0 Not tainted 4.5.0-rc6-00038-gae2804a-dirty #5
[   13.002950] Hardware name: Freescale Layerscape 2085a RDB Board (DT)
[   13.009333] Workqueue: events_unbound call_usermodehelper_exec_work
[   13.015623] Call trace:
[   13.018076] [<ffff800000089760>] dump_backtrace+0x0/0x1ac
[   13.023492] [<ffff800000089920>] show_stack+0x14/0x1c
[   13.028560] [<ffff80000032c1d4>] dump_stack+0x8c/0xb0
[   13.033627] [<ffff8000001aebdc>] dump_header.isra.7+0x4c/0x18c
[   13.039480] [<ffff800000152130>] oom_kill_process+0x26c/0x45c
[   13.045243] [<ffff800000152688>] out_of_memory+0x2e0/0x32c
[   13.050745] [<ffff800000156c68>] __alloc_pages_nodemask+0x83c/0x848
[   13.057031] [<ffff800000156f78>] alloc_kmem_pages_node+0x30/0xa8
[   13.063058] [<ffff8000000b776c>] copy_process.isra.42.part.43+0x128/0x1488
[   13.069955] [<ffff8000000b8c4c>] _do_fork+0xcc/0x338
[   13.074934] [<ffff8000000b8f04>] kernel_thread+0x34/0x3c
[   13.080261] [<ffff8000000cb8e0>] call_usermodehelper_exec_work+0x2c/0xd8
[   13.086984] [<ffff8000000ce4b0>] process_one_work+0x134/0x2f4
[   13.092747] [<ffff8000000ce6c8>] worker_thread+0x58/0x43c
[   13.098162] [<ffff8000000d3f88>] kthread+0xd8/0xec
[   13.102967] [<ffff800000085cd0>] ret_from_fork+0x10/0x40
[   13.261745] Mem-Info:

Thanks and Regards
Harry++
