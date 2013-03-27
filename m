From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 27 Mar 2013 21:43:47 +1100
Subject: [PATCH] ARM: davinci: use is IS_ENABLED macro
In-Reply-To: <1364210495-7938-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1364210495-7938-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <20130327214347.f2a573510416b86223c58be1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 25 Mar 2013 16:51:35 +0530 Prabhakar lad <prabhakar.csengg@gmail.com> wrote:
>
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -298,7 +298,7 @@ static const short da830_evm_emif25_pins[] = {
>  	-1
>  };
>  
> -#if defined(CONFIG_MMC_DAVINCI) || defined(CONFIG_MMC_DAVINCI_MODULE)
> +#if IS_ENABLED(CONFIG_MMC_DAVINCI)
>  #define HAS_MMC	1
>  #else
>  #define HAS_MMC	0

Why not

#define HAS_MMC		IS_ENABLED(CONFIG_MMC_DAVINCI)

and similarly in the rest?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/d026757d/attachment.sig>
