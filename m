From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Dec 2013 18:41:53 +0000
Subject: [PATCH 02/10] arm: select ARCH_MIGHT_HAVE_PC_SERIO
In-Reply-To: <1387040376-26906-3-git-send-email-msalter@redhat.com>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-3-git-send-email-msalter@redhat.com>
Message-ID: <20131214184153.GM4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 11:59:28AM -0500, Mark Salter wrote:
> Architectures which might use an i8042 for serial IO to keyboard,
> mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c1f1a7e..6990dc5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -6,6 +6,7 @@ config ARM
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> +	select ARCH_MIGHT_HAVE_PC_SERIO if FOOTBRIDGE_HOST
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select BUILDTIME_EXTABLE_SORT if MMU

It would be better to put this in arch/arm/mach-footbridge/Kconfig -
ARM is impled as being true there.

Thanks.
