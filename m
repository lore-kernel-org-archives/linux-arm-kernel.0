From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 14:34:03 +0100
Subject: [PATCH v3 4/7] ARM: KVM: enforce maximum size for identity
 mapped code
In-Reply-To: <1365779932-20322-5-git-send-email-marc.zyngier@arm.com>
References: <1365779932-20322-1-git-send-email-marc.zyngier@arm.com>
 <1365779932-20322-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130419133403.GP14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 04:18:49PM +0100, Marc Zyngier wrote:
> We're about to move to an init procedure where we rely on the
> fact that the init code fits in a single page. Make sure we
> align the idmap text on a vector alignment, and that the code is
> not bigger than a single page.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kernel/vmlinux.lds.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b571484..a871b8e 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -20,7 +20,7 @@
>  	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
>  	*(.idmap.text)							\
>  	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> -	ALIGN_FUNCTION();						\
> +	. = ALIGN(32);							\

It would be a good idea to document what this 32 is.
