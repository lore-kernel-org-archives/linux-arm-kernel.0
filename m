From: yegor.yefremov@visionsystems.de (Yegor Yefremov)
Date: Wed, 19 Mar 2014 11:39:12 +0100
Subject: [PATCHv2] ARM: OMAP2+: Use pdata quirks for wl12xx on the AM335x
 EV-MSK
In-Reply-To: <op.xcxlvsl42s3iss@ecaz>
References: <1393837376-25779-1-git-send-email-kaloz@openwrt.org>
 <5326BB1B.8030900@visionsystems.de> <op.xcxlvsl42s3iss@ecaz>
Message-ID: <532973D0.8010405@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.03.2014 20:03, Imre Kaloz wrote:
> Hi Yegor,
> 
> On Mon, 17 Mar 2014 10:06:35 +0100, Yegor Yefremov <yegor.yefremov@visionsystems.de> wrote:
> 
>> I have some trouble with WLAN. If I make extensive scanning (just start NetworkManager and wait a minute or so) I get following errors over and over again:
>>
>> [  717.608550] wlcore: Scan completed due to error.
>> [  717.613422] ------------[ cut here ]------------
>> [  717.618405] WARNING: CPU: 0 PID: 940 at drivers/net/wireless/ti/wlcore/main.c:789 wl12xx_queue_recovery_work+0x60/0x6c()
>> [  717.629832] Modules linked in:
>> [  717.633055] CPU: 0 PID: 940 Comm: kworker/u2:2 Tainted: G        W    3.14.0-rc4-12737-gefb78a0-dirty #214
>> [  717.643264] Workqueue: phy0 wl1271_scan_complete_work
>> [  717.648649] [<c00151e0>] (unwind_backtrace) from [<c0011e38>] (show_stack+0x10/0x14)
>> [  717.656762] [<c0011e38>] (show_stack) from [<c05a1944>] (dump_stack+0x7c/0x94)
>> [  717.664372] [<c05a1944>] (dump_stack) from [<c00402bc>] (warn_slowpath_common+0x6c/0x90)
>> [  717.672876] [<c00402bc>] (warn_slowpath_common) from [<c004037c>] (warn_slowpath_null+0x1c/0x24)
>> [  717.682110] [<c004037c>] (warn_slowpath_null) from [<c035be0c>] (wl12xx_queue_recovery_work+0x60/0x6c)
>> [  717.691889] [<c035be0c>] (wl12xx_queue_recovery_work) from [<c036d804>] (wl1271_scan_complete_work+0xf8/0x108)
>> [  717.702391] [<c036d804>] (wl1271_scan_complete_work) from [<c0058ff4>] (process_one_work+0x1ac/0x4c4)
>> [  717.712110] [<c0058ff4>] (process_one_work) from [<c0059e88>] (worker_thread+0x114/0x3b4)
>> [  717.720707] [<c0059e88>] (worker_thread) from [<c005fa44>] (kthread+0xcc/0xe8)
>> [  717.728306] [<c005fa44>] (kthread) from [<c000e388>] (ret_from_fork+0x14/0x2c)
>> [  717.735856] ---[ end trace f4d374bb2ca37664 ]---
>> [  717.743587] wlcore: Hardware recovery in progress. FW ver: Rev 6.3.10.0.133
>> [  717.752600] wlcore: pc: 0x0, hint_sts: 0x00000020 count: 6
>> [  717.759609] wlcore: down
>> [  717.764108] ieee80211 phy0: Hardware restart was requested
>> [  718.250930] wlcore: firmware booted (Rev 6.3.10.0.133)
>>
>> Have you experienced such behavior?
> 
> With older firmwares, quite often. 6.3.10.0.133 sounds amazingly old, the latest is 8.8.0.0.13. What kernel are you on?

I'm using Jorjin WG7311-2A on my custom board and I also have EVMSK with LBEE5ZSTNC-523(WL1271L). My kernel version is 3.14.0-rc4-12737-gefb78a0-dirty. Where do I get 8.8.0.0.13? AFAIK I'm using the latest firmware from here: https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/ti-connectivity

This is either wl127x-fw-5-sr.bin or wl127x-fw-5-mr.bin

Yegor
