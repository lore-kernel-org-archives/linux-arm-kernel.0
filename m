From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 10:35:51 +0200
Subject: [PATCH 4/9] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <1431677507-27420-5-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-5-git-send-email-shawnguo@kernel.org>
Message-ID: <3390971.xfPD4sbn1V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 16:11:42 shawnguo at kernel.org wrote:
>  }
>  
> +static void imx1_gpt_setup_tctl(void)
> +{
> +       u32 tctl_val;
> +
> +       tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> +       __raw_writel(tctl_val, imxtm.base + MXC_TCTL);
> +}
> 

Could you add another upfront patch to convert all the __raw_readl/__raw_writel
to readl_relaxed/writel_relaxed?

It would be nice if the driver was endian-safe by the time it gets moved to
drivers/clocksource, and you don't add any unsafe accesses for the changed
code.

	Arnd
