From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 22 Sep 2012 11:33:14 -0400
Subject: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120922153313.GN4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:

> +config SND_DAVINCI_HAVE_SRAM
> +	bool
> +	default y if ARCH_DAVINCI=y
> +	default n if ARCH_OMAP=y
> +

I've been sitting on this mostly since it seems like a step back from
multi-platform kernels (which is where we're trying to get to) and I've
been trying to decide what the best approach is.  I'm thinking that we
do want a generic API for allocating this stuff, it's a fairly generic
feature (there's TCMs as well).  

Adding ifdefs like this does just doesn't seem good.
