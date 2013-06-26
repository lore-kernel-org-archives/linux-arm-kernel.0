From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 26 Jun 2013 17:26:19 +0000 (UTC)
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <51CAEB33.5010101@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
Message-ID: <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jun 2013, Rajendra Nayak wrote:

> Apart from confirming if you are manually enabling these options, can you also give some
> details on how you append the dtb to the kernel image?
> 
> Most of us use an out-of-tree patch from Grant to do this, which I have shared below [2]
> 
> Even without the patch with the below commands [1] to append the dtb, it still works, so it
> would be good to know what steps you follow to append the dtb to the kernel image.

Here's how I do it:

ARCH=arm CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX} nice make -j$CORES zImage am335x-bone.dtb

cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone

scripts/mkuboot.sh -A arm -O linux -C none  -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux-' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone


- Paul
