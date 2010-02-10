From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 10 Feb 2010 08:53:15 +0100
Subject: [PATCH 2/3] mx25: add platform support for imxfb
In-Reply-To: <63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<63f40f35fe8cdea681d8341af36a4c539086f7ef.1265786237.git.baruch@tkos.co.il>
Message-ID: <20100210075315.GB10185@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 10, 2010 at 09:25:19AM +0200, Baruch Siach wrote:
> @@ -233,6 +242,9 @@ int __init mx25_clocks_init(void)
>  	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
>  	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
>  
> +	/* Clock source for lcdc is upll */
> +	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7), CRM_BASE + 0x64);
> +
0x64?  Please define a register name for that constant.  Ditto for 7.

Note I didn't look in the hardware manual, but I wonder if that should
better go in the enable routine for lcdc?


Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
