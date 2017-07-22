From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 22 Jul 2017 20:12:40 +0200
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <dff231c6-feb4-fc15-75e9-cc5696ad2e55@suse.de>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <634582831.41619.1500728895557@email.1und1.de>
 <dff231c6-feb4-fc15-75e9-cc5696ad2e55@suse.de>
Message-ID: <7a432eab-f65b-fdae-3e9f-e4095b19012a@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.07.2017 um 15:33 schrieb Andreas F?rber:
> Hi Stefan,
> 
> Am 22.07.2017 um 15:08 schrieb Stefan Wahren:
>> Andreas F?rber <afaerber@suse.de> hat am 22. Juli 2017 um 14:29 geschrieben:
>>> With arm64 4.13-rc1 I get no eth0 device on Pi3 (openSUSE Tumbleweed).
>>> The v4.13-rc1 DT works okay with a 4.12 kernel.
>>
>> do you use arm64/defconfig or a modified one?
> 
> I had updated our custom config via oldconfig, the result is here:
> 
> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default

USB related errors also show up on the Zero with a USB Ethernet
adapter/hub. There the device remains available and working though.

[  769.471986] ksoftirqd/0: page allocation failure: order:3,
mode:0x1284020(GFP_ATOMIC|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
[  769.483530] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.13.0-rc1-2.g9c198f2-default #1
[  769.491618] Hardware name: BCM2835
[  769.495071] [<c011b3fc>] (unwind_backtrace) from [<c0117aa4>]
(show_stack+0x18/0x1c)
[  769.502839] [<c0117aa4>] (show_stack) from [<c021d24c>]
(warn_alloc+0xb4/0x16c)
[  769.510163] [<c021d24c>] (warn_alloc) from [<c021dd94>]
(__alloc_pages_nodemask+0x9f4/0xe64)
[  769.518626] [<c021dd94>] (__alloc_pages_nodemask) from [<c0263080>]
(cache_alloc_refill+0xe0/0x990)
[  769.527685] [<c0263080>] (cache_alloc_refill) from [<c0263f08>]
(__kmalloc+0x158/0x188)
[  769.535932] [<c0263f08>] (__kmalloc) from [<bf12caa8>]
(dwc2_map_urb_for_dma+0xb8/0x118 [dwc2])
[  769.544815] [<bf12caa8>] (dwc2_map_urb_for_dma [dwc2]) from
[<c059d45c>] (usb_hcd_submit_urb+0xb4/0x9ec)
[  769.554404] [<c059d45c>] (usb_hcd_submit_urb) from [<bf197400>]
(rx_submit+0x154/0x2c8 [usbnet])
[  769.563285] [<bf197400>] (rx_submit [usbnet]) from [<bf197b90>]
(rx_complete+0x2ac/0x308 [usbnet])
[  769.572301] [<bf197b90>] (rx_complete [usbnet]) from [<c059b5bc>]
(__usb_hcd_giveback_urb+0xa0/0x14c)
[  769.581538] [<c059b5bc>] (__usb_hcd_giveback_urb) from [<c059b6ec>]
(usb_giveback_urb_bh+0x84/0xb8)
[  769.590600] [<c059b6ec>] (usb_giveback_urb_bh) from [<c01301cc>]
(tasklet_action+0x60/0xac)
[  769.598960] [<c01301cc>] (tasklet_action) from [<c012f884>]
(__do_softirq+0xd0/0x2f0)
[  769.606798] [<c012f884>] (__do_softirq) from [<c012fad0>]
(run_ksoftirqd+0x2c/0x44)
[  769.614481] [<c012fad0>] (run_ksoftirqd) from [<c014bb0c>]
(smpboot_thread_fn+0x104/0x188)
[  769.622761] [<c014bb0c>] (smpboot_thread_fn) from [<c0147ee4>]
(kthread+0x138/0x150)
[  769.630514] [<c0147ee4>] (kthread) from [<c0113138>]
(ret_from_fork+0x14/0x3c)
[  769.637734] Mem-Info:
[  769.640025] active_anon:7547 inactive_anon:7455 isolated_anon:0
[  769.640025]  active_file:29517 inactive_file:49366 isolated_file:0
[  769.640025]  unevictable:20 dirty:133 writeback:0 unstable:0
[  769.640025]  slab_reclaimable:20 slab_unreclaimable:133
[  769.640025]  mapped:10320 shmem:66 pagetables:271 bounce:0
[  769.640025]  free:933 free_pcp:62 free_cma:0
[  769.672717] Node 0 active_anon:30188kB inactive_anon:29820kB
active_file:118068kB inactive_file:197464kB unevictable:80kB
isolated(anon):0kB isolated(file):0kB mapped:41280kB dirty:532kB
writeback:0kB shmem:264kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? no
[  769.696194] Normal free:3732kB min:2536kB low:3168kB high:3800kB
active_anon:30188kB inactive_anon:29820kB active_file:118068kB
inactive_file:197464kB unevictable:80kB writepending:532kB
present:425984kB managed:410140kB mlocked:80kB kernel_stack:512kB
pagetables:1084kB bounce:0kB free_pcp:248kB local_pcp:248kB free_cma:0kB
[  769.724859] lowmem_reserve[]: 0 0 0
[  769.728352] Normal: 199*4kB (UH) 187*8kB (UMEH) 90*16kB (U) 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3732kB
[  769.740389] 78955 total pagecache pages
[  769.744221] 0 pages in swap cache
[  769.747532] Swap cache stats: add 0, delete 0, find 0/0
[  769.752751] Free swap  = 505648kB
[  769.756060] Total swap = 505648kB
[  769.759369] 106496 pages RAM
[  769.762243] 0 pages HighMem/MovableOnly
[  769.766072] 3961 pages reserved
[  769.769749] ksoftirqd/0: page allocation failure: order:3,
mode:0x1284020(GFP_ATOMIC|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
[  769.781274] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.13.0-rc1-2.g9c198f2-default #1
[  769.789360] Hardware name: BCM2835
[  769.792804] [<c011b3fc>] (unwind_backtrace) from [<c0117aa4>]
(show_stack+0x18/0x1c)
[  769.800568] [<c0117aa4>] (show_stack) from [<c021d24c>]
(warn_alloc+0xb4/0x16c)
[  769.807891] [<c021d24c>] (warn_alloc) from [<c021dd94>]
(__alloc_pages_nodemask+0x9f4/0xe64)
[  769.816355] [<c021dd94>] (__alloc_pages_nodemask) from [<c0263080>]
(cache_alloc_refill+0xe0/0x990)
[  769.825415] [<c0263080>] (cache_alloc_refill) from [<c0263f08>]
(__kmalloc+0x158/0x188)
[  769.833634] [<c0263f08>] (__kmalloc) from [<bf12caa8>]
(dwc2_map_urb_for_dma+0xb8/0x118 [dwc2])
[  769.842501] [<bf12caa8>] (dwc2_map_urb_for_dma [dwc2]) from
[<c059d45c>] (usb_hcd_submit_urb+0xb4/0x9ec)
[  769.852083] [<c059d45c>] (usb_hcd_submit_urb) from [<bf197400>]
(rx_submit+0x154/0x2c8 [usbnet])
[  769.860954] [<bf197400>] (rx_submit [usbnet]) from [<bf197b90>]
(rx_complete+0x2ac/0x308 [usbnet])
[  769.869969] [<bf197b90>] (rx_complete [usbnet]) from [<c059b5bc>]
(__usb_hcd_giveback_urb+0xa0/0x14c)
[  769.879208] [<c059b5bc>] (__usb_hcd_giveback_urb) from [<c059b6ec>]
(usb_giveback_urb_bh+0x84/0xb8)
[  769.888268] [<c059b6ec>] (usb_giveback_urb_bh) from [<c01301cc>]
(tasklet_action+0x60/0xac)
[  769.896629] [<c01301cc>] (tasklet_action) from [<c012f884>]
(__do_softirq+0xd0/0x2f0)
[  769.904465] [<c012f884>] (__do_softirq) from [<c012fad0>]
(run_ksoftirqd+0x2c/0x44)
[  769.912146] [<c012fad0>] (run_ksoftirqd) from [<c014bb0c>]
(smpboot_thread_fn+0x104/0x188)
[  769.920424] [<c014bb0c>] (smpboot_thread_fn) from [<c0147ee4>]
(kthread+0x138/0x150)
[  769.928175] [<c0147ee4>] (kthread) from [<c0113138>]
(ret_from_fork+0x14/0x3c)
[  769.935420] ax88179_178a 1-1.1:1.0 eth0: kevent 2 may have been dropped
[  769.942484] ksoftirqd/0: page allocation failure: order:3,
mode:0x1284020(GFP_ATOMIC|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
[  769.954008] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.13.0-rc1-2.g9c198f2-default #1
[  769.962096] Hardware name: BCM2835
[  769.965539] [<c011b3fc>] (unwind_backtrace) from [<c0117aa4>]
(show_stack+0x18/0x1c)
[  769.973303] [<c0117aa4>] (show_stack) from [<c021d24c>]
(warn_alloc+0xb4/0x16c)
[  769.980627] [<c021d24c>] (warn_alloc) from [<c021dd94>]
(__alloc_pages_nodemask+0x9f4/0xe64)
[  769.989090] [<c021dd94>] (__alloc_pages_nodemask) from [<c0263080>]
(cache_alloc_refill+0xe0/0x990)
[  769.998147] [<c0263080>] (cache_alloc_refill) from [<c0263f08>]
(__kmalloc+0x158/0x188)
[  770.006362] [<c0263f08>] (__kmalloc) from [<bf12caa8>]
(dwc2_map_urb_for_dma+0xb8/0x118 [dwc2])
[  770.015230] [<bf12caa8>] (dwc2_map_urb_for_dma [dwc2]) from
[<c059d45c>] (usb_hcd_submit_urb+0xb4/0x9ec)
[  770.024810] [<c059d45c>] (usb_hcd_submit_urb) from [<bf197400>]
(rx_submit+0x154/0x2c8 [usbnet])
[  770.033679] [<bf197400>] (rx_submit [usbnet]) from [<bf197b90>]
(rx_complete+0x2ac/0x308 [usbnet])
[  770.042695] [<bf197b90>] (rx_complete [usbnet]) from [<c059b5bc>]
(__usb_hcd_giveback_urb+0xa0/0x14c)
[  770.051931] [<c059b5bc>] (__usb_hcd_giveback_urb) from [<c059b6ec>]
(usb_giveback_urb_bh+0x84/0xb8)
[  770.060991] [<c059b6ec>] (usb_giveback_urb_bh) from [<c01301cc>]
(tasklet_action+0x60/0xac)
[  770.069350] [<c01301cc>] (tasklet_action) from [<c012f884>]
(__do_softirq+0xd0/0x2f0)
[  770.077187] [<c012f884>] (__do_softirq) from [<c012fad0>]
(run_ksoftirqd+0x2c/0x44)
[  770.084868] [<c012fad0>] (run_ksoftirqd) from [<c014bb0c>]
(smpboot_thread_fn+0x104/0x188)
[  770.093145] [<c014bb0c>] (smpboot_thread_fn) from [<c0147ee4>]
(kthread+0x138/0x150)
[  770.100896] [<c0147ee4>] (kthread) from [<c0113138>]
(ret_from_fork+0x14/0x3c)
[  770.108141] ax88179_178a 1-1.1:1.0 eth0: kevent 2 may have been dropped

https://kernel.opensuse.org/cgit/kernel-source/plain/config/armv6hl/default

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
