From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Tue, 6 Oct 2009 12:53:18 +0200
Subject: [PATCH] SA1100: fix building of h3100
In-Reply-To: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
References: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20091006125318.d430a642.kristoffer.ericson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Oct 2009 21:50:34 +0400
Dmitry Artamonow <mad_soft@inbox.ru> wrote:

> Both iPaqs h3100 and h3600 currently share the same source
> file - h3600.c  But Makefile builds it only if CONFIG_SA1100_H3600
> selected, so selecting just CONFIG_SA1100_H3100 results in
> "no machine record defined" message and aborted compilation.
> 
> Fix it.

Acked

> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---
> Well, it left unnoticed by me for a while, just because I always build
> kernels with _both_ machines compiled in.
> 
>  arch/arm/mach-sa1100/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
> index 8a5546e..bb7b819 100644
> --- a/arch/arm/mach-sa1100/Makefile
> +++ b/arch/arm/mach-sa1100/Makefile
> @@ -25,6 +25,7 @@ led-$(CONFIG_SA1100_CERF)		+= leds-cerf.o
>  
>  obj-$(CONFIG_SA1100_COLLIE)		+= collie.o
>  
> +obj-$(CONFIG_SA1100_H3100)		+= h3600.o
>  obj-$(CONFIG_SA1100_H3600)		+= h3600.o
>  
>  obj-$(CONFIG_SA1100_HACKKIT)		+= hackkit.o
> -- 
> 1.6.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
