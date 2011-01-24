From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Mon, 24 Jan 2011 14:43:15 +0530
Subject: [PATCH v1 0/5] davinci: da850: clean up pinmux arrays in da850.c
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302485AD393@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 18, 2011 at 22:51:41, Michael Williamson wrote:
> The following patch series is an attempt to clean up unused and platform specific
> pinmux arrays in the da850 CPU files.  This series was developed as a result of 
> the following email thread:
> 
> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg19921.html
> 
> This patch is against commit cda6ca38f96f0719ce3500da856e7d4bf0abbc38 of linux-davinci.
> 
> This series should not be applied until someone with a da850 EVM can please test
> and confirm the mcasp and mmc interfaces continue to work properly with these patches.
> 
> ---
>   changes since v0:
>   - correct use of __initdata/__initconst attributes
> 
> Michael Williamson (5):
>   davinci: da850: remove unused pinmux array
>   davinci: da850: remove unused emif pinmux array
>   davinci: da850: move da850_evm specific mcasp pins to board file.
>   davinci: da850: move da850_evm specific mmcsd pinmux array to board
>     file.
>   davinci: da850: remove unused uart pinmux arrays.
> 
>  arch/arm/mach-davinci/board-da850-evm.c    |   18 ++++++++-
>  arch/arm/mach-davinci/da850.c              |   56 ----------------------------
>  arch/arm/mach-davinci/include/mach/da8xx.h |    7 ---
>  3 files changed, 16 insertions(+), 65 deletions(-)
> 

These patches apply cleanly to davinci tree at [1].

The kernel was built using da8xx_omapl_defconfig.

Tested Ethernet (booted using NFS), UART, Audio, MMC/SD and NAND.

For the entire series:
Tested-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary

Thanks,
Sudhakar
