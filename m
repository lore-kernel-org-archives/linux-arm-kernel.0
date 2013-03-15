From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 17:23:10 +0000
Subject: [PATCH 1/3] ARM: allow platforms to use generic headers
 without ARCH_MULTIPLATFORM
In-Reply-To: <1363193598-28116-2-git-send-email-jonathan.austin@arm.com>
References: <1363193598-28116-1-git-send-email-jonathan.austin@arm.com>
 <1363193598-28116-2-git-send-email-jonathan.austin@arm.com>
Message-ID: <20130315172310.GO4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 04:53:16PM +0000, Jonathan Austin wrote:
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index df89983..5c6fd05 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -25,7 +25,7 @@ unsigned int __machine_arch_type;
>  static void putstr(const char *ptr);
>  extern void error(char *x);
>  
> -#ifdef CONFIG_ARCH_MULTIPLATFORM
> +#ifdef CONFIG_ARM_GENERIC_HEADERS

Note that this will conflict with patches I've just merged.  I wouldn't
suggest you rely on those patches yet until they've had some wider
testing, so I'd recommend you hold off with these for a while.
