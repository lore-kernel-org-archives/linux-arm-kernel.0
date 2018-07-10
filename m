From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jul 2018 15:02:13 +0100
Subject: next/master boot: 173 boots: 4 failed, 136 passed with 32
 offline, 1 untried/unknown (next-20180710)
In-Reply-To: <5b44b87b.1c69fb81.97804.0122@mx.google.com>
References: <5b44b87b.1c69fb81.97804.0122@mx.google.com>
Message-ID: <20180710140213.GB8104@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 06:45:31AM -0700, kernelci.org bot wrote:

Today's linux-next fails to boot on mt7622-rfb1 with defconfig and
defconfig+RANDOMIZE_BASE:

> arm64:

>     defconfig:
>         mt7622-rfb1:
>             lab-baylibre-seattle: new failure (last pass: next-20180709)

>     defconfig+CONFIG_RANDOMIZE_BASE=y:
>         mt7622-rfb1:
>             lab-baylibre-seattle: new failure (last pass: next-20180709)

I'm not 100% sure if this is a lab failure or an early boot failure:

| Starting kernel ...

| [ATF][    34.233534]save kernel info
| [ATF][    34.236565]Kernel_EL2
| [ATF][    34.239322]Kernel is 64Bit
| [ATF][    34.242509]pc=0x40080000, r0=0x5cf48000, r1=0x0
| INFO:    BL3-1: Preparing for EL3 exit to normal world, Kernel
| INFO:    BL3-1: Next image address = 0x40080000
| INFO:    BL3-1: Next image spsr = 0x3c9
| [ATF][    34.260778]el3_exit
| ~$off
| # PYBOOT: Exception: kernel: ERROR: did not start booting.

It only seems to affect this platform, other arm64 platforms seem fine.
More details at:

   https://kernelci.org/boot/id/5b44981a59b5141e5996baa1/

for the defconfig case, symptoms seem similar with RANDOMIZE_BASE.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/d8650215/attachment.sig>
