From: lukasz.goralczyk@gmail.com (=?UTF-8?Q?=C5=81ukasz_G=C3=B3ralczyk?=)
Date: Thu, 27 May 2010 15:24:29 +0200
Subject: Problem with at91_mci and AT91RM9200
Message-ID: <1274966669.2465.105.camel@arcturus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently I bough a cheap board with Atmel AT92RM9200 CPU and
preinstalled patched kernel 2.6.21 to play with. Board is NGX Blueboard
ARM9 and it's based (almost a 1:1 copy) on ECB_AT91
( http://en.wikipedia.org/wiki/ECB_AT91 ) which is supported in kernel.
I was able to do basic things with it (boot from SD, Ethernet).

I compiled newest kernel (2.6.33.4 and 2.6.32 with at91 patches
http://www.at91.com/linux4sam/bin/view/Linux4SAM/LinuxKernel#AT91_Linux_kernel_sources_summar )
which boots but fails to detect SD Card (Sandisk microSD 2 GB through SD
adapter). A the end there's a debugging output (stripped, full:
http://liku.ayz.pl/at91mmc ).

I started to look for a cause of the problem but asking here may save me
some time:
* does anybody still, successfully, uses this CPU and newest at_mci
driver?
* What might be the cause of this error?
* Perhaps CPU is it too obsolete and I should stay with old kernel
(+errata has a lot of problems for mci subsystem)?

What I have already tried:
* I checked hardware connections between card socket and CPU (as well as
other possible hardware causes),
* tried at91 and atmel mci driver, on atmel mci driver nothing happens,
* tried different kernel versions (patched .32 and unpatched .33),
* started to patch new kernel with old patches from ECB but whole mci
subsystem changed.

Regards,
Lukasz.

--- start ---
[cut]
at91_mci at91_mci: 4 wire bus mode not supported - using 1 wire
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
MMC: Setting controller bus width to 1
Added MCI driver
mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
MMC: Setting controller bus width to 1
TCP cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 17
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
clkdiv = 74. mcck = 399360
MMC: Setting controller bus width to 1
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
clkdiv = 74. mcck = 399360
MMC: Setting controller bus width to 1
at91_rtc at91_rtc: setting system clock to 1998-01-01 00:00:24 UTC
(883612824)
Waiting 1sec before mounting root device...
mmc0: starting CMD0 arg 00000000 flags 000000c0
Sending command 0 as 00000800, arg = 00000000, blocks = 0, length = 0
(MR = 0000834A)
MCI irq: status = 0000C0E5, C07F0001, 00000001
Command ready
Completed command
Status = 00000001/0000c0e5 [00000000 00000000 00000000 00000000]
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
clkdiv = 74. mcck = 399360
MMC: Setting controller bus width to 1
mmc0: starting CMD8 arg 000001aa flags 000002f5
Sending command 8 as 00001848, arg = 000001AA, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0010C0E5, C07F0001, 00100001
MMC: Response timeout
Completed command
Status = 00100001/0010c0e5 [00000000 00000000 00000000 00000000]
Error detected and set to -110/0 (cmd = 8, retries = 0)
mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0010C0E5, C07F0001, 00100001
MMC: Response timeout
Completed command
Status = 00100001/0010c0e5 [00000000 00000000 00000000 00000000]
Error detected and set to -110/0 (cmd = 5, retries = 3)
mmc0: req failed (CMD5): -110, retrying...
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0010C0E5, C07F0001, 00100001
MMC: Response timeout
Completed command
Status = 00100001/0010c0e5 [00000000 00000000 00000000 00000000]
Error detected and set to -110/0 (cmd = 5, retries = 2)
mmc0: req failed (CMD5): -110, retrying...
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0010C0E5, C07F0001, 00100001
MMC: Response timeout
Completed command
Status = 00100001/0010c0e5 [00000000 00000000 00000000 00000000]
Error detected and set to -110/0 (cmd = 5, retries = 1)
mmc0: req failed (CMD5): -110, retrying...
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0010C0E5, C07F0001, 00100001
MMC: Response timeout
Completed command
Status = 00100001/0010c0e5 [00000000 00000000 00000000 00000000]
Error detected and set to -110/0 (cmd = 5, retries = 0)
mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0002C0E4, C07F0001, 00020000
MMC: Response direction error
Completed command
Status = 00020000/0006c0e5 [FFFFFFFF 00000000 00000000 00000000]
Error detected and set to -5/0 (cmd = 55, retries = 0)
mmc0: req done (CMD55): -5: ffffffff 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0002C0E4, C07F0001, 00020000
MMC: Response direction error
Completed command
Status = 00020000/0006c0e5 [FFFFFFFF 00000000 00000000 00000000]
Error detected and set to -5/0 (cmd = 55, retries = 0)
mmc0: req done (CMD55): -5: ffffffff 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0002C0E4, C07F0001, 00020000
MMC: Response direction error
Completed command
Status = 00020000/0006c0e5 [FFFFFFFF 00000000 00000000 00000000]
Error detected and set to -5/0 (cmd = 55, retries = 0)
mmc0: req done (CMD55): -5: ffffffff 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0002C0E4, C07F0001, 00020000
MMC: Response direction error
Completed command
Status = 00020000/0006c0e5 [FFFFFFFF 00000000 00000000 00000000]
Error detected and set to -5/0 (cmd = 55, retries = 0)
mmc0: req done (CMD55): -5: ffffffff 00000000 00000000 00000000
mmc0: starting CMD1 arg 00000000 flags 000000e1
Sending command 1 as 00001841, arg = 00000000, blocks = 0, length = 0
(MR = 0000034A)
MCI irq: status = 0002C0E4, C07F0001, 00020000
MMC: Response direction error
Completed command
Status = 00020000/0006c0e5 [FFFFFFFF 00000000 00000000 00000000]
Error detected and set to -5/0 (cmd = 1, retries = 0)
mmc0: req done (CMD1): -5: ffffffff 00000000 00000000 00000000
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
MMC: Setting controller bus width to 1
VFS: Cannot open root device "mmcblk0p1" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available
partitions:
[cut]
--- end ---
