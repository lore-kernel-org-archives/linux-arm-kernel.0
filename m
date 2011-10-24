From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Oct 2011 08:58:53 +0200
Subject: [RFC PATCH 08/15] ARM: uncompress: Rename misc.c to print.c
In-Reply-To: <1319404245-12740-8-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-8-git-send-email-zoss@devai.org>
Message-ID: <20111024065853.GO15299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:10:38PM +0200, Zoltan Devai wrote:
> Now that misc.c only holds functions related to printout
> during decompression, rename it accordingly.
> 
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
>  arch/arm/boot/compressed/Makefile |    2 +-
>  arch/arm/boot/compressed/misc.c   |  122 -------------------------------------
>  arch/arm/boot/compressed/print.c  |  122 +++++++++++++++++++++++++++++++++++++
If you add -M to git-format-patch this gets much easier to review.

>  3 files changed, 123 insertions(+), 123 deletions(-)
>  delete mode 100644 arch/arm/boot/compressed/misc.c
>  create mode 100644 arch/arm/boot/compressed/print.c
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index e4f32a8..d955d4f 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -23,7 +23,7 @@ endif
>  
>  AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
>  HEAD	= head.o
> -OBJS	+= misc.o decompress.o
> +OBJS	+= print.o decompress.o
>  FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
>  
>  # string library code (-Os is enforced to keep it much smaller)
> [...]
> diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
> new file mode 100644
> index 0000000..25f0fb2
> --- /dev/null
> +++ b/arch/arm/boot/compressed/print.c
> @@ -0,0 +1,122 @@
> +/*
> + * misc.c
This is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
