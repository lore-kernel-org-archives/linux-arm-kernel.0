From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 07 Sep 2010 13:35:24 +0400
Subject: [PATCH] pxa: fix cpu_is_pxa*() not expanded to zero when not
	configured
In-Reply-To: <AANLkTinqc=k3H0QL5PKNu6Je=qs=GBNAQ21nv5HkvGom@mail.gmail.com>
References: <AANLkTinqc=k3H0QL5PKNu6Je=qs=GBNAQ21nv5HkvGom@mail.gmail.com>
Message-ID: <4C86075C.30802@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-09-2010 8:09, Eric Miao wrote:

> Could you give this a run?

> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
> b/arch/arm/mach-pxa/include/mach/hardware.h
> index 7f64d24..b036500 100644
> --- a/arch/arm/mach-pxa/include/mach/hardware.h
> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
> @@ -264,23 +264,35 @@
>    *<= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
>    * == 0x3 for pxa300/pxa310/pxa320
>    */
> +#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
>   #define __cpu_is_pxa2xx(id)				\
>   	({						\
>   		unsigned int _id = (id)>>  13&  0x7;	\
>   		_id<= 0x2;				\
>   	 })
> +#else
> +#define __cpu_is_pxa2xx(id)	(0)

    Why enclose 0 in parens?

WBR, Sergei
