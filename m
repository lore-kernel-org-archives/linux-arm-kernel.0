From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2009 19:41:32 +0000
Subject: [PATCH 4/4]ARM: NUC900: enable uart support for nuc932
In-Reply-To: <4B167281.1090708@gmail.com>
References: <4B167281.1090708@gmail.com>
Message-ID: <20091203194132.GA27666@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 09:58:25PM +0800, Wan ZongShun wrote:
> diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
> index b9ea2e6..2a2a54a 100644
> --- a/arch/arm/mach-w90x900/clock.h
> +++ b/arch/arm/mach-w90x900/clock.h
> @@ -14,8 +14,10 @@
>  
>  #ifndef CONFIG_CPU_NUC932
>  #define EXTCLK	15000000
> +#define UARTCLK	11313600
>  #else
>  #define EXTCLK	27000000
> +#define UARTCLK	57139200
>  #endif

As far as I can see, these are the only thing which prevent a single
kernel being built to cover both NUC900 and NUC932.

Can we make their selection something which is done at runtime instead
of compile time?  This comments goes for patch 5837/1 in the patch
system as well.
