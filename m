From: nm@ti.com (Nishanth Menon)
Date: Mon, 14 Dec 2015 12:42:57 -0600
Subject: [PATCH V2 0/3] ARM: multi_v7_defconfig: Enable more OMAP family
 platforms
Message-ID: <1450118580-24754-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

V1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336582.html
V2: is just a rebase of the series on top ov v4.4-rc5

Ran into all kinds of test farm issues recently, hence the delay in repost.. I
still seem to have a few more quirks to resolve in the board test farm.. but
as far as I can see, things look better after the series.

Series baseline: v4.4-rc5 (applies on next-20151214 as well)

Plain v4.4-rc5
 1:          am335x-evm: BOOT: PASS: err=5 warn=24: http://pastebin.ubuntu.com/14008259/
 2:           am335x-sk: BOOT: PASS: err=3 warn=20: http://pastebin.ubuntu.com/14008260/
 3:          am3517-evm: BOOT: PASS: alert=1 err=12 warn=45: http://pastebin.ubuntu.com/14008261/
 4:           am37x-evm: BOOT: PASS: err=5 warn=20: http://pastebin.ubuntu.com/14008263/
 5:           am437x-sk: BOOT: FAIL: http://pastebin.ubuntu.com/14008265/
 6:         am43xx-epos: BOOT: PASS: err=7 warn=20: http://pastebin.ubuntu.com/14008266/
 7:        am43xx-gpevm: BOOT: PASS: err=10 warn=25: http://pastebin.ubuntu.com/14008267/
 8:     BeagleBoard-X15: BOOT: PASS: http://pastebin.ubuntu.com/14008268/
 9:      BeagleBoard-XM: BOOT: PASS: err=15 warn=10: http://pastebin.ubuntu.com/14008270/
10: beagleboard-vanilla: BOOT: PASS: err=8 warn=12: http://pastebin.ubuntu.com/14008271/
11:    beaglebone-black: BOOT: PASS: err=4 warn=13: http://pastebin.ubuntu.com/14008272/
12:          beaglebone: BOOT: FAIL: http://pastebin.ubuntu.com/14008273/
13:          craneboard: BOOT: PASS: err=15 warn=45: http://pastebin.ubuntu.com/14008275/
14:          dra72x-evm: BOOT: PASS: err=5 warn=11: http://pastebin.ubuntu.com/14008276/
15:          dra7xx-evm: BOOT: PASS: err=4 warn=9: http://pastebin.ubuntu.com/14008277/
16:             ldp3430: BOOT: FAIL: http://pastebin.ubuntu.com/14008278/
17:                n900: BOOT: PASS: err=5 warn=13: http://pastebin.ubuntu.com/14008280/
18:           omap5-evm: BOOT: PASS: err=11 warn=16: http://pastebin.ubuntu.com/14008281/
19:       pandaboard-es: BOOT: PASS: err=17 warn=24: http://pastebin.ubuntu.com/14008282/
20:  pandaboard-vanilla: BOOT: PASS: err=17 warn=23: http://pastebin.ubuntu.com/14008283/
21:             sdp3430: BOOT: PASS: err=17 warn=14: http://pastebin.ubuntu.com/14008284/
22:             sdp4430: BOOT: PASS: err=20 warn=27: http://pastebin.ubuntu.com/14008285/
TOTAL = 22 boards, Booted Boards = 19, No Boot boards = 3

v4.4-rc5 + this series:
 1:          am335x-evm: BOOT: PASS: err=5 warn=22: http://pastebin.ubuntu.com/14010157/
 2:          am3517-evm: BOOT: PASS: alert=1 err=12 warn=45: http://pastebin.ubuntu.com/14010160/
 3:           am37x-evm: BOOT: PASS: err=5 warn=20: http://pastebin.ubuntu.com/14010161/
 4:           am437x-sk: BOOT: PASS: err=10 warn=20: http://pastebin.ubuntu.com/14010162/
 5:         am43xx-epos: BOOT: PASS: err=7 warn=20: http://pastebin.ubuntu.com/14010166/
 6:        am43xx-gpevm: BOOT: PASS: err=10 warn=25: http://pastebin.ubuntu.com/14010168/
 7:     BeagleBoard-X15: BOOT: PASS: err=4 warn=13: http://pastebin.ubuntu.com/14010170/
 8:      BeagleBoard-XM: BOOT: PASS: err=15 warn=10: http://pastebin.ubuntu.com/14010171/
 9: beagleboard-vanilla: BOOT: PASS: err=8 warn=12: http://pastebin.ubuntu.com/14010172/
10:    beaglebone-black: BOOT: PASS: err=4 warn=15: http://pastebin.ubuntu.com/14010173/
11:          beaglebone: BOOT: PASS: err=4 warn=11: http://pastebin.ubuntu.com/14010176/
12:          craneboard: BOOT: FAIL: http://pastebin.ubuntu.com/14010179/
13:          dra72x-evm: BOOT: PASS: err=5 warn=11: http://pastebin.ubuntu.com/14010180/
14:          dra7xx-evm: BOOT: PASS: err=4 warn=15: http://pastebin.ubuntu.com/14010183/
15:             ldp3430: BOOT: FAIL: http://pastebin.ubuntu.com/14010184/
16:                n900: BOOT: PASS: err=5 warn=13: http://pastebin.ubuntu.com/14010185/
17:           omap5-evm: BOOT: PASS: err=11 warn=16: http://pastebin.ubuntu.com/14010188/
18:       pandaboard-es: BOOT: PASS: err=17 warn=24: http://pastebin.ubuntu.com/14010189/
19:  pandaboard-vanilla: BOOT: PASS: err=17 warn=22: http://pastebin.ubuntu.com/14010191/
20:             sdp3430: BOOT: PASS: err=17 warn=14: http://pastebin.ubuntu.com/14010192/
21:             sdp4430: BOOT: PASS: err=20 warn=27: http://pastebin.ubuntu.com/14010193/
TOTAL = 21 boards, Booted Boards = 19, No Boot boards = 2

Craneboard failure in the log was traced to older arago filesystem used -> need
to update all boards soonish..

LDP is more interesting failure: http://pastebin.ubuntu.com/14010254/ change helps LDP3430 bootup.
It does look like a driver bug of some sort at this point in time..


Nishanth Menon (3):
  ARM: multi_v7_defconfig: Enable beaglebone PMIC TPS65217
  ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
  ARM: multi_v7_defconfig: Enable generic SoC internal OMAP regulators

 arch/arm/configs/multi_v7_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

-- 
1.7.9.5
