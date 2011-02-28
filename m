From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 10:04:03 +0000
Subject: [PATCH 6/8] ARM i.MX5: Allow to increase max zone order
In-Reply-To: <1298887229-7987-7-git-send-email-s.hauer@pengutronix.de>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
	<1298887229-7987-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110228100403.GA29843@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 11:00:27AM +0100, Sascha Hauer wrote:
> default setting of 11 allows us to allocate at maximum
> 2MB chunks of contiguous memory. For resolutions up to
> 1920x1080 32bpp we need much more memory, so make zone
> order configurable

Wouldn't it be better to add another 'default' in there for ARCH_MX5
rather than expecting whoever configures the kernel to be able to work
out the right value?

>  config FORCE_MAX_ZONEORDER
> -	int "Maximum zone order" if ARCH_SHMOBILE
> -	range 11 64 if ARCH_SHMOBILE
> +	int "Maximum zone order" if ARCH_SHMOBILE || ARCH_MX5
> +	range 11 64 if ARCH_SHMOBILE || ARCH_MX5
>  	default "9" if SA1111
>  	default "11"
>  	help
