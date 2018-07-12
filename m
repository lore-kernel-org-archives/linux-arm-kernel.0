From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 12 Jul 2018 14:01:44 +0800
Subject: next/master boot: 173 boots: 4 failed, 136 passed with 32
 offline, 1 untried/unknown (next-20180710)
In-Reply-To: <20180710140213.GB8104@sirena.org.uk>
References: <5b44b87b.1c69fb81.97804.0122@mx.google.com>
 <20180710140213.GB8104@sirena.org.uk>
Message-ID: <1531375304.26214.26.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

thanks for reporting this issue.

I have fixed the issue in [1], which is caused by an update on pinctrl
core and the driver doesn't have an immediate follow-up to the change.

Hi, Matthias

Could you help to add earlycon I posted in [2], which is helpful to
identify at which point the boot is stuck instead of no any hint in the
console?

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-July/014070.html


[2]
http://lists.infradead.org/pipermail/linux-mediatek/2018-June/013709.html


On Tue, 2018-07-10 at 15:02 +0100, Mark Brown wrote:
> On Tue, Jul 10, 2018 at 06:45:31AM -0700, kernelci.org bot wrote:
> 
> Today's linux-next fails to boot on mt7622-rfb1 with defconfig and
> defconfig+RANDOMIZE_BASE:
> 
> > arm64:
> 
> >     defconfig:
> >         mt7622-rfb1:
> >             lab-baylibre-seattle: new failure (last pass: next-20180709)
> 
> >     defconfig+CONFIG_RANDOMIZE_BASE=y:
> >         mt7622-rfb1:
> >             lab-baylibre-seattle: new failure (last pass: next-20180709)
> 
> I'm not 100% sure if this is a lab failure or an early boot failure:
> 
> | Starting kernel ...
> 
> | [ATF][    34.233534]save kernel info
> | [ATF][    34.236565]Kernel_EL2
> | [ATF][    34.239322]Kernel is 64Bit
> | [ATF][    34.242509]pc=0x40080000, r0=0x5cf48000, r1=0x0
> | INFO:    BL3-1: Preparing for EL3 exit to normal world, Kernel
> | INFO:    BL3-1: Next image address = 0x40080000
> | INFO:    BL3-1: Next image spsr = 0x3c9
> | [ATF][    34.260778]el3_exit
> | ~$off
> | # PYBOOT: Exception: kernel: ERROR: did not start booting.
> 
> It only seems to affect this platform, other arm64 platforms seem fine.
> More details at:
> 
>    https://kernelci.org/boot/id/5b44981a59b5141e5996baa1/
> 
> for the defconfig case, symptoms seem similar with RANDOMIZE_BASE.
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
