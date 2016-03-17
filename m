From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Mar 2016 10:46:45 +0000
Subject: [PATCH] ARM: use --fix-v4bx to allow building ARMv4 with future
 gcc
In-Reply-To: <12678426.5oeMNXL25J@wuerfel>
References: <12678426.5oeMNXL25J@wuerfel>
Message-ID: <20160317104645.GZ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 11:38:30AM +0100, Arnd Bergmann wrote:
> Compiling with -march=armv4t leads the compiler to using 'bx reg'
> instructions instead of 'ld pc,reg'. This is not supported on

ITYM mov pc, reg

> However, in order to still allow users of old toolchains to link
> the kernel, we only pass the option to linkers that support it,
> based on a $(ld-option ...) call. I'm intentionally passing the
> flag to all linker versions here regardless of whether it's needed
> or not, so we can more easily spot any regressions if something
> goes wrong.
> 
> For consistency, I'm passing the --fix-v4bx flag for both the
> vmlinux final link and the individual loadable modules.
> The module loader code already interprets the R_ARM_V4BX relocations
> in loadable modules and converts bx instructions into ldr even

MOV.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
