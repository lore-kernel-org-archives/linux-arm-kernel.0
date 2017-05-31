From: angus@akkea.ca (Angus Ainslie)
Date: Wed, 31 May 2017 10:29:08 -0600
Subject: Staging r8723bs driver for kernel 4.12.0-rc2 on CHIPPro
In-Reply-To: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
References: <bcc1a7c44ba34cb077a1df09971d6926@www.akkea.ca>
Message-ID: <8485e88721d4761d5b1a10ff1eebfd36@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-24 15:03, Angus Ainslie wrote:
> Hi
> 
> Has the realtek rtl8723bs staging driver in kernel 4.12.0-rc2 been
> tested on the CHIPPro.
> 

This is still an issue with 4.12.0-rc3

> The SDIO device is getting recognized but the driver doesn't load.
> 
> chip at chippro:~$ dmesg | grep mmc
> [    5.440000] bus: 'platform': driver_probe_device: matched device
> mmc0_pwrseq with driver pwrseq_simple
> [    5.440000] bus: 'platform': really_probe: probing driver
> pwrseq_simple with device mmc0_pwrseq
> [    5.440000] pwrseq_simple mmc0_pwrseq: no init pinctrl state
> [    5.440000] sun5i-pinctrl 1c20800.pinctrl: request pin 42 (PB10)
> for mmc0_pwrseq
> [    5.440000] pwrseq_simple mmc0_pwrseq: no sleep pinctrl state
> [    5.440000] pwrseq_simple mmc0_pwrseq: no idle pinctrl state
> [    5.440000] devices_kset: Moving mmc0_pwrseq to end of list
> [    5.440000] driver: 'pwrseq_simple': driver_bound: bound to device
> 'mmc0_pwrseq'
> [    5.440000] bus: 'platform': really_probe: bound device mmc0_pwrseq
> to driver pwrseq_simple
> [    5.440000] bus: 'platform': add driver pwrseq_emmc
> [    5.440000] bus: 'mmc': add driver mmcblk
> [    5.450000] bus: 'platform': add driver sunxi-mmc
> [    5.450000] bus: 'platform': driver_probe_device: matched device
> 1c0f000.mmc with driver sunxi-mmc
> [    5.450000] bus: 'platform': really_probe: probing driver sunxi-mmc
> with device 1c0f000.mmc
> [    5.450000] sunxi-mmc 1c0f000.mmc: no init pinctrl state
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 160 (PF0)
> for 1c0f000.mmc
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 161 (PF1)
> for 1c0f000.mmc
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 162 (PF2)
> for 1c0f000.mmc
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 163 (PF3)
> for 1c0f000.mmc
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 164 (PF4)
> for 1c0f000.mmc
> [    5.450000] sun5i-pinctrl 1c20800.pinctrl: request pin 165 (PF5)
> for 1c0f000.mmc
> [    5.450000] sunxi-mmc 1c0f000.mmc: no sleep pinctrl state
> [    5.450000] sunxi-mmc 1c0f000.mmc: no idle pinctrl state
> [    5.450000] devices_kset: Moving 1c0f000.mmc to end of list
> [    5.450000] sunxi-mmc 1c0f000.mmc: No vqmmc regulator found
> [    5.450000] sunxi-mmc 1c0f000.mmc: allocated mmc-pwrseq
> [    5.460000] device: 'mmc0': device_add
> [    5.460000] PM: Adding info for No Bus:mmc0
> [    5.460000] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width
> 1 timing 0
> [    5.460000] sunxi-mmc 1c0f000.mmc: power on!
> [    5.460000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.460000] sunxi-mmc 1c0f000.mmc: Initial signal voltage of 3.3v
> [    5.490000] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
> width 1 timing 0
> [    5.490000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.490000] sunxi-mmc 1c0f000.mmc: setting clk to 400000, rounded 
> 400000
> [    5.490000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.520000] sunxi-mmc 1c0f000.mmc: base:0xd021f000 irq:20
>                                        [360/1889]
> [    5.520000] driver: 'sunxi-mmc': driver_bound: bound to device 
> '1c0f000.mmc'
> [    5.520000] bus: 'platform': really_probe: bound device 1c0f000.mmc
> to driver sunxi-mmc
> [    5.540000] mmc0: mmc_rescan_try_freq: trying to init card at 400000 
> Hz
> [    5.550000] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [    5.550000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg c00 ie
> 0x0000bbc6 len 0
> [    5.550000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e54 mi 00000004 idi 
> 00000000
> [    5.550000] mmc0: req done (CMD52): 0: 00005000 00000000 00000000 
> 00000000
> [    5.550000] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [    5.550000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 80000c08 ie
> 0x0000bbc6 len 0
> [    5.550000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e54 mi 00000004 idi 
> 00000000
> [    5.550000] mmc0: req done (CMD52): 0: 00001008 00000000 00000000 
> 00000000
> [    5.550000] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
> width 1 timing 0
> [    5.550000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.550000] sunxi-mmc 1c0f000.mmc: setting clk to 400000, rounded 
> 400000
> [    5.550000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.560000] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    5.560000] sunxi-mmc 1c0f000.mmc: cmd 0(80008000) arg 0 ie 
> 0x0000bbc6 len 0
> [    5.560000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e7c mi 00000004 idi 
> 00000000
> [    5.560000] mmc0: req done (CMD0): 0: 00001008 00000000 00000000 
> 00000000
> [    5.560000] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
> width 1 timing 0
> [    5.560000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.560000] sunxi-mmc 1c0f000.mmc: setting clk to 400000, rounded 
> 400000
> [    5.560000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.560000] mmc0: starting CMD8 arg 000001aa flags 000002f5
> [    5.560000] sunxi-mmc 1c0f000.mmc: cmd 8(80000148) arg 1aa ie
> 0x0000bbc6 len 0
> [    5.560000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e7c mi 00000100 idi 
> 00000000
> [    5.560000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e7c mi 00000004 idi 
> 00000000
> [    5.560000] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 8, RTO !!
> [    5.560000] mmc0: req done (CMD8): -110: 00000000 00000000 00000000 
> 00000000
> [    5.570000] mmc0: starting CMD5 arg 00000000 flags 000002e1
> [    5.570000] sunxi-mmc 1c0f000.mmc: cmd 5(80000045) arg 0 ie 
> 0x0000bbc6 len 0
> [    5.570000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e34 mi 00000004 idi 
> 00000000
> [    5.570000] mmc0: req done (CMD5): 0: 90ffffff 00000000 00000000 
> 00000000
> [    5.570000] sunxi-mmc 1c0f000.mmc: card claims to support voltages
> below defined range
> [    5.580000] mmc0: starting CMD5 arg 00200000 flags 000002e1
> [    5.580000] sunxi-mmc 1c0f000.mmc: cmd 5(80000045) arg 200000 ie
> 0x0000bbc6 len 0
> [    5.580000] sunxi-mmc 1c0f000.mmc: irq: rq cf543ddc mi 00000004 idi 
> 00000000
> [    5.580000] mmc0: req done (CMD5): 0: 90ffffff 00000000 00000000
> 00000000                                  [322/1889]
> [    5.580000] mmc0: starting CMD3 arg 00000000 flags 00000075
> [    5.580000] sunxi-mmc 1c0f000.mmc: cmd 3(80000143) arg 0 ie 
> 0x0000bbc6 len 0
> [    5.580000] sunxi-mmc 1c0f000.mmc: irq: rq cf543de4 mi 00000004 idi 
> 00000000
> [    5.580000] mmc0: req done (CMD3): 0: 00010000 00000000 00000000 
> 00000000
> [    5.640000] mmc0: starting CMD7 arg 00010000 flags 00000015
> [    5.640000] sunxi-mmc 1c0f000.mmc: cmd 7(80000147) arg 10000 ie
> 0x0000bbc6 len 0
> [    5.640000] sunxi-mmc 1c0f000.mmc: irq: rq cf543de4 mi 00000004 idi 
> 00000000
> [    5.640000] mmc0: req done (CMD7): 0: 00001e00 00000000 00000000 
> 00000000
> [    5.640000] mmc0: starting CMD52 arg 00000000 flags 00000195
> [    5.640000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 0 ie 
> 0x0000bbc6 len 0
> [    5.640000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dd4 mi 00000004 idi 
> 00000000
> [    5.640000] mmc0: req done (CMD52): 0: 00000032 00000000 00000000 
> 00000000
> [    5.640000] mmc0: starting CMD52 arg 00001000 flags 00000195
> [    5.640000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 1000 ie
> 0x0000bbc6 len 0
> [    5.640000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dd4 mi 00000004 idi 
> 00000000
> [    5.640000] mmc0: req done (CMD52): 0: 00001013 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00002400 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 2400 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dd4 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00002600 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 2600 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dd4 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00001200 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 1200 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00001400 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 1400 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001010 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00001600 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 1600 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00200000 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200200 ie
> 0x0000bbc6 len 0                         [280/1889]
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001004 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00200400 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200400 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 0000104c 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00200600 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200600 ie
> 0x0000bbc6 len 0
> [    5.650000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.650000] mmc0: req done (CMD52): 0: 00001002 00000000 00000000 
> 00000000
> [    5.650000] mmc0: starting CMD52 arg 00200800 flags 00000195
> [    5.650000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001023 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00200a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 000010d7 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00200c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001021 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00200e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 200e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001002 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 0000100c 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001022 00000000 00000000
> 00000000                                 [242/1889]
> [    5.660000] mmc0: starting CMD52 arg 00201600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001004 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001008 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00201e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 201e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001032 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00202000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 202000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543d84 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 000010ff 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00002600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 2600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543db4 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 80002603 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 80002603 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543db4 mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001003 00000000 00000000 
> 00000000
> [    5.660000] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
> width 1 timing 2
> [    5.660000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.660000] sunxi-mmc 1c0f000.mmc: setting clk to 400000, rounded 
> 400000
> [    5.660000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.660000] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd
> 21 width 1 timing 2
> [    5.660000] sunxi-mmc 1c0f000.mmc: disabling the clock
>                                        [204/1889]
> [    5.660000] sunxi-mmc 1c0f000.mmc: setting clk to 50000000, rounded 
> 50000000
> [    5.660000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.660000] mmc0: starting CMD52 arg 00000e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dac mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 80000e02 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 80000e02 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dac mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001002 00000000 00000000 
> 00000000
> [    5.660000] mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd
> 21 width 4 timing 2
> [    5.660000] sunxi-mmc 1c0f000.mmc: disabling the clock
> [    5.660000] sunxi-mmc 1c0f000.mmc: setting clk to 50000000, rounded 
> 50000000
> [    5.660000] sunxi-mmc 1c0f000.mmc: enabling the clock
> [    5.660000] mmc0: starting CMD52 arg 00020000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 20000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543e2c mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001007 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00021200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 21200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00021400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 21400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001011 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00021600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 21600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001021 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 0000100c 00000000 00000000
> 00000000                                 [162/1889]
> [    5.660000] mmc0: starting CMD52 arg 00220600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001022 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 0000102a 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00220e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 220e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221a00 ie
> 0x0000bbc6 len 0                         [120/1889]
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00221e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 221e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001002 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 000010ff 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00222c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 222c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000
> 00000000                                  [74/1889]
> [    5.660000] mmc0: starting CMD52 arg 00223200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00223e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 223e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224800 ie
> 0x0000bbc6 len 0                          [28/1889]
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224c00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224c00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00224e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 224e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 000010eb 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225200 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225200 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225400 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225400 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 0000106e 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225600 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225600 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001001 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225800 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225800 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225a00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225a00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00225e00 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 225e00 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 00001000 00000000 00000000 
> 00000000
> [    5.660000] mmc0: starting CMD52 arg 00226000 flags 00000195
> [    5.660000] sunxi-mmc 1c0f000.mmc: cmd 52(80000174) arg 226000 ie
> 0x0000bbc6 len 0
> [    5.660000] sunxi-mmc 1c0f000.mmc: irq: rq cf543dcc mi 00000004 idi 
> 00000000
> [    5.660000] mmc0: req done (CMD52): 0: 000010ff 00000000 00000000 
> 00000000
> [    5.660000] mmc0: new high speed SDIO card at address 0001
> [    5.670000] device: 'mmc0:0001': device_add
> [    5.670000] bus: 'mmc': add device mmc0:0001
> [    5.670000] PM: Adding info for mmc:mmc0:0001
> [    5.670000] bus: 'mmc': driver_probe_device: matched device
> mmc0:0001 with driver mmcblk
> [    5.670000] bus: 'mmc': really_probe: probing driver mmcblk with
> device mmc0:0001
> [    5.670000] mmcblk mmc0:0001: no of_node; not parsing pinctrl DT
> [    5.670000] mmcblk mmc0:0001: no default pinctrl state
> [    5.670000] devices_kset: Moving mmc0:0001 to end of list
> [    5.670000] mmcblk: probe of mmc0:0001 rejects match -19
> [    5.670000] device: 'mmc0:0001:1': device_add
