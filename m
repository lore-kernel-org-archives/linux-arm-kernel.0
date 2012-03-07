From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Mar 2012 19:40:22 -0300
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <1331159314-12022-2-git-send-email-w.sang@pengutronix.de>
References: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
 <1331159314-12022-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <CAOMZO5C9EDi_Hy-8=iphr+154gyPgBLnjSVV0seLgi+HoK4zRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 7:28 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
...
> +static int stmp_clear_poll_bit(void __iomem *addr, u32 mask)
> +{
> + ? ? ? int timeout = 0x400;

Could you please add a proper timeout mechanism here?

Something like: http://patchwork.ozlabs.org/patch/137365/

,as you suggested in the first place ;-)

> +
> + ? ? ? writel(mask, addr + STMP_OFFSET_REG_CLR);
> + ? ? ? udelay(1);
> + ? ? ? while ((readl(addr) & mask) && --timeout)
> + ? ? ? ? ? ? ? /* nothing */;
> +
> + ? ? ? return !timeout;
> +}
> +
> +int stmp_reset_block(void __iomem *reset_addr)
> +{
> + ? ? ? int ret;
> + ? ? ? int timeout = 0x400;

Same here.

Regards,

Fabio Estevam
