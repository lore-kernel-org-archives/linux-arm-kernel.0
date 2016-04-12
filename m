From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Apr 2016 12:29:00 +0530
Subject: [PATCH] ARM: davinci: only use NVMEM when available
In-Reply-To: <1458077705-408437-1-git-send-email-arnd@arndb.de>
References: <1458077705-408437-1-git-send-email-arnd@arndb.de>
Message-ID: <570C9CB4.9090409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 March 2016 03:04 AM, Arnd Bergmann wrote:
> The davinci platform contains code that calls into the nvmem
> subsystem, but that might be a loadable module, causing a
> link error:
> 
> arch/arm/mach-davinci/built-in.o: In function `davinci_get_mac_addr':
> :(.text+0x1088): undefined reference to `nvmem_device_read'
> arch/arm/mach-davinci/built-in.o: In function `read_factory_config':
> :(.text+0x214c): undefined reference to `nvmem_device_read'
> 
> Also, when NVMEM is completely disabled, the functions fail with
> nonobvious error messages.
> 
> This ensures we only call the API functions when the code is actually
> reachable from the board file, and otherwise prints a unique log
> message.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: bec3c11bad0e ("misc: at24: replace memory_accessor with nvmem_device_read")
> ---
> 
> Hi Greg,
> 
> The commit that introduced this is currently in the char-misc tree,
> please apply this fixup on top if you haven't already sent it to Linus.

I don't see this patch in Linus's tree still. I can send this fixup
through ARM-SoC since its all touching mach-davinci anyway. Let me know.

> 
>  arch/arm/mach-davinci/board-mityomapl138.c | 5 +++++
>  arch/arm/mach-davinci/common.c             | 5 +++++
>  2 files changed, 10 insertions(+)

Regards,
Sekhar
