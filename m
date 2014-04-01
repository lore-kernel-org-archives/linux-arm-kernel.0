From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 1 Apr 2014 09:31:15 -0700
Subject: [PATCH] ARM: bcm: Restrict ARCH_BCM selection to ARCH_MULTI_V6_V7
In-Reply-To: <1396340779-20550-1-git-send-email-shc_work@mail.ru>
References: <1396340779-20550-1-git-send-email-shc_work@mail.ru>
Message-ID: <CAAYSxhprUUHi5BQQcpe4XVwMgUXLiAjA-mh+=EveOby0TuDDtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 1:26 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> -if ARCH_BCM
> +         This enables support for Broadcom ARM based SoC chips
>
>  menu "Broadcom SoC Selection"
> +       depends on ARCH_BCM
>
>  config ARCH_BCM_MOBILE
>         bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
> @@ -71,5 +68,3 @@ config ARCH_BCM_5301X
>           network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
>
>  endmenu
> -
> -endif
> --
> 1.8.3.2

If applied on top of for-next of arm-soc, this won't do the right thing.

The if ARCH_BCM block will soon include config ARCH_BCM2835 and config
ARCH_BCM_5301X.

-Tim
