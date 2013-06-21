From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 18:19:36 +0200
Subject: [GIT PULL] Keystone SOC support for 3.11
In-Reply-To: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <201306211819.36288.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 June 2013, Santosh Shilimkar wrote:
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc
> 
> for you to fetch changes up to cc92fc07c26c1bec1abb58f0cd356b13dc00a28c:
> 
>   ARM: dts: keystone: Add minimal Keystone SOC device tree data (2013-06-14 19:45:46 -0400)
> 
> ----------------------------------------------------------------
> SOC support for Keystone II devices:
> 
> - Minimal machine and device-tree support with arch_timers and console UART
> - Reboot hook using PLL reset
> - Low level debug support using UART
> - SMP boot support

I'm getting a build warning with keystone_defconfig that I have not 
encountered before:

arch/arm/mm/fault.c:495:1: warning: 'do_sect_fault' defined but not used [-Wunused-function]
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 ^

Any idea what is going on here and what the fix is? Should that function
just be hidden in #ifndef CONFIG_ARM_LPAE?

	Arnd
