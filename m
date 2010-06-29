From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Jun 2010 08:58:17 +0200
Subject: Subject: [PATCH] arm: fix KConfig warning for mach-mx25
In-Reply-To: <201006290005.20875.PeterHuewe@gmx.de>
References: <201006290005.20875.PeterHuewe@gmx.de>
Message-ID: <20100629065817.GA23160@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiho,

[added linux-kbuild at vger.kernel.org to Cc:]

On Tue, Jun 29, 2010 at 12:05:20AM +0200, Peter H?we wrote:
> From: Peter Huewe <peterhuewe@gmx.de
> 
> This patch fixes a KConfig warning:
> "arch/arm/mach-mx25/Kconfig:18:warning: choice value used outside its
> choice group"
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
The problem also goes away when renaming one of the two
MACH_EUKREA_MBIMXSD_BASEBOARD (the other MACH_EUKREA_MBIMXSD_BASEBOARD
is in arch/arm/mach-mx3/Kconfig).  AFAIK Eric already sent a patch to
fix this.  I think this is the real issue, I don't know why the warning
goes away with your patch.

Nevertheless I like your patch.  And note there are two other variables
in arch/arm/mach-mx2 that could benefit from the same "fix".  (But as I
moved this file in my tree I suggest to wait until my changes hit Linus'
tree and then fix arch/arm/mach-imx/Kconfig.)

Best regards
Uwe

> ---
> KernelVersion: linux-next-20100628
>  arch/arm/mach-mx25/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
> index 3a6668e..2f436ed 100644
> --- a/arch/arm/mach-mx25/Kconfig
> +++ b/arch/arm/mach-mx25/Kconfig
> @@ -15,8 +15,7 @@ choice
>  	default MACH_EUKREA_MBIMXSD_BASEBOARD
>  
>  config MACH_EUKREA_MBIMXSD_BASEBOARD
> -	prompt "Eukrea MBIMXSD development board"
> -	bool
> +	bool "Eukrea MBIMXSD development board"
>  	help
>  	  This adds board specific devices that can be found on Eukrea's
>  	  MBIMXSD evaluation board.
> -- 
> 1.7.1

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
