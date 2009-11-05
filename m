From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Nov 2009 19:17:18 +0100
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA4B5901@dbde02.ent.ti.com>
References: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FA4B5901@dbde02.ent.ti.com>
Message-ID: <20091105181718.GB7221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 05, 2009 at 07:25:45PM +0530, Pandita, Vikram wrote:
> 
> >-----Original Message-----
> >From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> >bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> >Sent: Thursday, November 05, 2009 4:35 AM
> >To: linux-arm-kernel at lists.infradead.org
> >Cc: Sascha Hauer; Uwe Kleine-K?nig
> >Subject: [RFC PATCH] Add an earlyprintk debug console
> >
> >This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
> >using the printch asm function.
> >
> >The patch is based on the original work by Sascha Hauer.
> 
> Nice work...
> Linux-omap has been using for couple of years this hackery, which finally has a solution now:
> 
> diff --git a/kernel/printk.c b/kernel/printk.c
> index f38b07f..1def076 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -36,6 +36,10 @@
> 
> +#ifdef CONFIG_DEBUG_LL
> +       printascii(printk_buf);
> +#endif
> 
>         p = printk_buf;
I guess this won't be accepted, as kernel/printk.c is generic code,
CONFIG_DEBUG_LL is ARM specific.  (And IIRC you need to declare
printascii first.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
