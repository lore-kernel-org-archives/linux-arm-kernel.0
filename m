From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Sep 2012 20:12:48 +0000
Subject: [PATCH] ARM: imx: armadillo5x0: Fix illegal register access
In-Reply-To: <1347736516-10697-1-git-send-email-festevam@gmail.com>
References: <1347736516-10697-1-git-send-email-festevam@gmail.com>
Message-ID: <201209152012.49195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 September 2012, Fabio Estevam wrote:
> 
>         /* set NAND page size to 2k if not configured via boot mode pins */
> -       __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
> +       __raw_writel(__raw_readl(mx3_ccm_base + MXC_CCM_RCSR) |
> +                                               (1 << 30), MXC_CCM_RCSR);
>  
>         /* RTC */

Shouldn't you change both the read and the write here, rather than just the read?

	Arnd
