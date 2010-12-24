From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Dec 2010 11:49:04 +0000
Subject: [PATCH 2/4] ARM: SAMSUNG: Add SMDK audio configuration
In-Reply-To: <1293172938-23615-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
	<1293172938-23615-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101224114904.GA15926@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 03:42:18PM +0900, Seungwhan Youn wrote:

>  	select S3C_DEV_HSMMC
> +	select SMDK_HAS_WM9710_AC97 if ASOC_SAMSUNG
>  	help

There's no need for the ifs here - since the actual machine driver is a
user visible control and the SMDK_HAS_ are just dependencies for that
it's more normal to just select the symbol.
