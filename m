From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Dec 2013 20:47:04 +0100
Subject: Freeze on Colibri T20 about 5 minutes after boot (3.13-rc1)
Message-ID: <24ee0eea02f6d60e8f67825061720004@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since updating to 3.13-rc1 I experience freezes on my Tegra based module
after 2-5 minutes after boot up. There is no stacktrace, the serial
console is dead as well as X turns black. 

I did a git bisect and could isolate the offending commit:
f52bb722547f43caeaecbcc62db9f3c3b80ead9b
ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses

My main cross compile toolchain is Linaro gnueabihf 4.7 (2013.04). I
also tested with Linaro gnueabihf 4.8 (2013.11).

I use tegra_defconfig with CONFIG_ARM_PATCH_PHYS_VIRT enabled. The
module uses the Tegra T20 SoC featuring two A9 ARM cores and no NEON
extension. I use a Yocto based root filesystem. Let me now if I can help
with testing...

--
Stefan
