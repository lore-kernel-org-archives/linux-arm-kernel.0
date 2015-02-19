From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 19 Feb 2015 23:10:55 +0200
Subject: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
In-Reply-To: <201502191920.41284@pali>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502191920.41284@pali>
Message-ID: <20150219211055.GB8558@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 19, 2015 at 07:20:41PM +0100, Pali Roh?r wrote:
> Anyway, in Nokia Harmattan N9/N950 2.6.32 kernel is this patch:

> +/* Do we need runtime check ? */
> +#if __LINUX_ARM_ARCH__ < 6
>  	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
> +#else
> +	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"I-cache maintenance fault"	   },
> +#endif

> Maybe it is related?

That was unrelated. Also, the patch is also in mainline,
see 8c0b742ca7a7d21de0ddc87eda6ef0b282e4de18 (ARM: 6134/1: Handle
instruction cache maintenance fault properly).

A.
