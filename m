From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Dec 2011 15:57:50 -0600
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
Message-ID: <4EDD3E5E.6050106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2011 03:22 PM, Linus Walleij wrote:
> Hi Nico,
> 
> now I'm lost, I discussed by boot problems on ARM PB1176
> with Marc and after some investigation I found this strange thing on
> the lastest rc:s since -rc1:
> 
> In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
> disabled like so:
> 
> depends on !ARCH_REALVIEW || !SPARSEMEM

should be !ARCH_REALVIEW && !SPARSEMEM ?

Rob

> 
> However if I just configure it for the realview_defconfig:
> 
> mkdir foo
> make -f Makefile ARCH=arm CROSS_COMPILE=arm-none-eabi-
> KBUILD_OUTPUT=foo realview_defconfig
> 
> It strangely selects this anyway, because now foo/.config has:
> CONFIG_ARM_PATCH_PHYS_VIRT=y
> 
> Kconfig is a djungle to me, but I simply cannot find out
> what is setting this anyway. The problem is not there on
> v3.1, it does not get selected.
> 
> Any hints?
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
