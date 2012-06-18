From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 12:37:16 +0100
Subject: [RFC PATCH 8/8] ARM: vmlinux.lds: Setup correct entry point to
 physical address
In-Reply-To: <1340019011-18642-9-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-9-git-send-email-monstr@monstr.eu>
Message-ID: <20120618113716.GG12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 01:30:11PM +0200, Michal Simek wrote:
> linker script setups entry point to virtual address.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> 
> ---
> Not sure what is the reason to setup entry point to virtual address.
> ---
>  arch/arm/kernel/vmlinux.lds.S |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b996bc0..de43b01 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -39,7 +39,7 @@
>  #endif
>  
>  OUTPUT_ARCH(arm)
> -ENTRY(stext)
> +ENTRY(arm_start)

stext etc better stay as the virtual address through this change.  The
kernel makes use of all stext/etext etc symbols as virtual addresses.
