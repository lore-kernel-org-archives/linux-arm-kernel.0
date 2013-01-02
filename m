From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jan 2013 22:59:21 +0000
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of
 ARCH_VEXPRESS by ARCH_MULTI_V7
In-Reply-To: <1353431918-9326-1-git-send-email-festevam@gmail.com>
References: <1353431918-9326-1-git-send-email-festevam@gmail.com>
Message-ID: <20130102225921.GH2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 03:18:38PM -0200, Fabio Estevam wrote:
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b9f38e3..aa46be8 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -310,4 +310,6 @@ SECTIONS
>   * binutils is too old (for other reasons as well)
>   */
>  ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
> +#ifndef CONFIG_ARCH_MULTIPLATFORM
>  ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
> +#endif

This is wrong.  So you want a kernel build which produces an unbootable
kernel (because it contains absolutely no platform support of any kind,
not even any DT platform support) to succeed?
