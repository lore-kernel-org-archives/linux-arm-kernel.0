From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 May 2013 10:43:08 +0100
Subject: [PATCH] ARM: plat-orion: Fix num_resources and id for ge10 and
 ge11
In-Reply-To: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
References: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130520094308.GU18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 10:12:43PM +0200, Gregory CLEMENT wrote:
>  static struct platform_device orion_ge10 = {
>  	.name		= MV643XX_ETH_NAME,
> -	.id		= 1,
> -	.num_resources	= 2,
> +	.id		= 2,
> +	.num_resources	= 1,

Please consider using:

	.num_resources	= ARRAY_SIZE(orion_ge10_resources),

to help you avoid having the wrong number of resources specified.
