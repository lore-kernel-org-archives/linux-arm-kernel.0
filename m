From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 20:32:02 -0600
Subject: [PATCH 2/2] arm: bcm2835: properly use IOMEM() to define virtual
 address constants
In-Reply-To: <1351419853-25146-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351419853-25146-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508F3C22.1000601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 04:24 AM, Thomas Petazzoni wrote:
> Like we now do for all ARM platforms, use IOMEM() to define virtual
> address constants, so that they get typed as 'void __iomem *'
> pointers. It for now requires a cast when defining the map_desc entry,
> but that cast should disappear once we switch map_desc to the usage of
> 'void __iomem *' pointers.

> diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c

>  static struct map_desc io_map __initdata = {
> -	.virtual = BCM2835_PERIPH_VIRT,
> +	.virtual = (unsigned long) BCM2835_PERIPH_VIRT,

Very nit-picky, but there shouldn't be a space after the cast there.
