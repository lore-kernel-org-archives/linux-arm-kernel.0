From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Mon, 12 Dec 2016 19:23:11 +0100
Subject: [RFT PATCH] ARM64: dts: meson-gxbb: Add reserved memory zone and
 usable memory range
In-Reply-To: <20161212101801.28491-1-narmstrong@baylibre.com>
References: <20161212101801.28491-1-narmstrong@baylibre.com>
Message-ID: <a4eadb9e-448b-ea78-465e-6c3591604f59@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 11:18 AM, Neil Armstrong wrote:
> The Amlogic Meson GXBB secure monitor uses part of the memory space, this
> patch adds these reserved zones and redefines the usable memory range for
> each boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 21 +++++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts     |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi    |  2 +-
>  .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts   |  2 +-
>  .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts    |  2 +-
>  .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts  |  2 +-
>  .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts      |  2 +-
>  .../arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  2 +-
>  11 files changed, 31 insertions(+), 10 deletions(-)
> 

I added your patch to next-20161212.

My kernel config is available as
https://github.com/xypron/kernel-odroid-c2/blob/5ec4be0c1b45297bbcbc1ce3d3d787e45dac66b6/config/config-next-20161212

To build the same kernel just run ./build-dpkg.sh (or make) on
https://github.com/xypron/kernel-odroid-c2/tree/5ec4be0c1b45297bbcbc1ce3d3d787e45dac66b6

Free showed 0x2301000 less total memory available than next-20161209
without the patch.

When git cloning linux-next I got the following error on Hardkernel
Odroid C2:

[  811.602365] Bad mode in Error handler detected on CPU2, code
0xbf000000 -- SError
[  811.604205] CPU: 2 PID: 1447 Comm: git Not tainted
4.9.0-next-20161212-r005-arm64 #1
[  811.611876] Hardware name: Hardkernel ODROID-C2 (DT)
[  811.616793] task: ffff8000745c5780 task.stack: ffff800072d3c000
[  811.622660] PC is at 0xaaaad3770f28
[  811.626107] LR is at 0xffffab54e53c
[  811.629558] pc : [<0000aaaad3770f28>] lr : [<0000ffffab54e53c>]
pstate: 20000000
[  811.636888] sp : 0000ffffd3a1d950
[  811.640166] x29: 0000ffffd3a1d950 x28: 0000ffff9853a050
[  811.645427] x27: 00000000000ffc5e x26: 0000ffff8fe00020
[  811.650688] x25: 0000ffffd3a1da98 x24: 0000000000000000
[  811.655949] x23: 0000aaaad3770f28 x22: 0000000000000010
[  811.661211] x21: 0000ffff9809bae0 x20: 000000000003de04
[  811.666472] x19: 0000ffff8fe00010 x18: 0000000023c57c32
[  811.671733] x17: 0000ffffab58f988 x16: 0000ffffab660008
[  811.676994] x15: 00000000000006dc x14: 0000000000000000
[  811.682255] x13: 00000000002549ea x12: 0000000029555c36
[  811.687517] x11: 00000000002549eb x10: 0000000029555c36
[  811.692778] x9 : 00000000002549ea x8 : 0000000029555c36
[  811.698039] x7 : 00000000002549e9 x6 : 0000000029555c36
[  811.703300] x5 : 0000ffff98d54b40 x4 : 0000ffff8f93c030
[  811.708562] x3 : 00000000ffffffff x2 : 0000000000000000
[  811.713823] x1 : 0000ffff9853a050 x0 : 0000ffff9809bae0

[  811.720561] Internal error: Attempting to execute userspace memory:
8600000f [#1] PREEMPT SMP
[  811.729004] Modules linked in: meson_rng rng_core ip_tables x_tables
ipv6 realtek
[  811.736422] CPU: 2 PID: 1447 Comm: git Not tainted
4.9.0-next-20161212-r005-arm64 #1
[  811.744097] Hardware name: Hardkernel ODROID-C2 (DT)
[  811.749014] task: ffff8000745c5780 task.stack: ffff800072d3c000
[  811.754879] PC is at 0xffffab54e53c
[  811.758328] LR is at 0xffffab54e53c
[  811.761779] pc : [<0000ffffab54e53c>] lr : [<0000ffffab54e53c>]
pstate: 600003c5
[  811.769109] sp : ffff800072d3fec0
[  811.772387] x29: 0000000000000000 x28: ffff8000745c5780
[  811.777648] x27: 00000000000ffc5e x26: 0000ffff8fe00020
[  811.782909] x25: 0000ffffd3a1da98 x24: 0000000000000000
[  811.788171] x23: 0000000020000000 x22: 0000aaaad3770f28
[  811.793432] x21: ffffffffffffffff x20: 000080006e538000
[  811.798693] x19: 0000000000000000 x18: 0000000000000010
[  811.803954] x17: 0000ffffab58f988 x16: 0000ffffab660008
[  811.809215] x15: 0000000000000006 x14: ffff000088b2eabf
[  811.814477] x13: ffff000008b2eacd x12: 0000000000000105
[  811.819738] x11: 0000000000000002 x10: 0000000000000106
[  811.824999] x9 : ffff800072d3fb40 x8 : 00000000000af8ec
[  811.830260] x7 : 0000000000000000 x6 : 0000000000000a65
[  811.835522] x5 : 000000000a660a65 x4 : 0000000000000000
[  811.840783] x3 : 0000000000000002 x2 : 0000000000000a66
[  811.846044] x1 : ffff8000745c5780 x0 : 0000000000000000

[  811.852773] Process git (pid: 1447, stack limit = 0xffff800072d3c000)
[  811.859156] Stack: (0xffff800072d3fec0 to 0xffff800072d40000)
[  811.864849] fec0: 0000ffff9809bae0 0000ffff9853a050 0000000000000000
00000000ffffffff
[  811.872611] fee0: 0000ffff8f93c030 0000ffff98d54b40 0000000029555c36
00000000002549e9
[  811.880374] ff00: 0000000029555c36 00000000002549ea 0000000029555c36
00000000002549eb
[  811.888136] ff20: 0000000029555c36 00000000002549ea 0000000000000000
00000000000006dc
[  811.895898] ff40: 0000ffffab660008 0000ffffab58f988 0000000023c57c32
0000ffff8fe00010
[  811.903661] ff60: 000000000003de04 0000ffff9809bae0 0000000000000010
0000aaaad3770f28
[  811.911423] ff80: 0000000000000000 0000ffffd3a1da98 0000ffff8fe00020
00000000000ffc5e
[  811.919186] ffa0: 0000ffff9853a050 0000ffffd3a1d950 0000ffffab54e53c
0000ffffd3a1d950
[  811.926949] ffc0: 0000aaaad3770f28 0000000020000000 0000000000000000
ffffffffffffffff
[  811.934711] ffe0: 0000000000000000 0000000000000000 3136363920746e61
3064613364666464
[  811.942473] Call trace:
[  811.944888] Exception stack(0xffff800072d3fcf0 to 0xffff800072d3fe20)
[  811.951270] fce0:                                   0000000000000000
0001000000000000
[  811.959034] fd00: ffff800072d3fec0 0000ffffab54e53c ffff8000731ab640
0000000000000000
[  811.966796] fd20: 0000000000000004 ffff000008ab9818 ffff8000745c5780
000000000808540c
[  811.974559] fd40: ffff800072d3fd90 ffff0000080c8858 ffff800072d3fe40
ffff8000745c5780
[  811.982321] fd60: 0000000000000004 00000000000003c0 ffff800072d3fe40
0000000000000000
[  811.990084] fd80: 0000ffffd3a1da98 0000ffff8fe00020 0000000000000000
ffff8000745c5780
[  811.997846] fda0: 0000000000000a66 0000000000000002 0000000000000000
000000000a660a65
[  812.005609] fdc0: 0000000000000a65 0000000000000000 00000000000af8ec
ffff800072d3fb40
[  812.013371] fde0: 0000000000000106 0000000000000002 0000000000000105
ffff000008b2eacd
[  812.021134] fe00: ffff000088b2eabf 0000000000000006 0000ffffab660008
0000ffffab58f988
[  812.028896] [<0000ffffab54e53c>] 0xffffab54e53c
[  812.033382] Code: aa1c03e1 aa1503e0 8b16027a d63f02e0 (7100001f)
[  812.039501] ---[ end trace e791f586be1831bb ]---
