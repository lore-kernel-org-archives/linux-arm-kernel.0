From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Oct 2012 10:43:40 +0000
Subject: [PATCH] arm: socfpga: fix build break for allyesconfig
In-Reply-To: <20121026230052.GA24573@elf.ucw.cz>
References: <1351289861-16297-1-git-send-email-dinguyen@altera.com>
 <20121026224358.GD21164@n2100.arm.linux.org.uk>
 <20121026230052.GA24573@elf.ucw.cz>
Message-ID: <201210271043.40569.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012, Pavel Machek wrote:
> arch/arm/mach-socfpga/headsmp.S:21: Error: attempt to use an ARM
> instruction on a Thumb-only processor -- `movw
> r0,#:lower16:(0xffd08000+0x10)'
> ...
> 
> Using .arch armv7-a indeed works and is a very nice solution.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -11,6 +11,7 @@
>  #include <linux/init.h>
>  
>         __INIT
> +       .arch   armv7-a
>  
>  #define HPS_SYSMGR_ADDRESS     0xffd08000
>  #define CONFIG_SYSTEM_MANAGER  HPS_SYSMGR_ADDRESS
> 

Thanks, applied with new commit message.

	Arnd
