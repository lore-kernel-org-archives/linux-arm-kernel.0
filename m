From: joe@perches.com (Joe Perches)
Date: Fri, 08 Apr 2011 12:28:01 -0700
Subject: [RFC][WAS:bcmai][PATCH V2] axi: add AXI bus driver
In-Reply-To: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
References: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
Message-ID: <1302290881.1664.7.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-08 at 21:45 +0200, Rafa? Mi?ecki wrote:
> diff --git a/include/linux/axi/axi.h b/include/linux/axi/axi.h
[]
> +#define axi_info	pr_info
> +#ifdef CONFIG_AXI_DEBUG
> +#define axi_debug	pr_debug
> +#else
> +#define axi_debug	do { } while (0)
> +#endif
> +#define axi_err		pr_err

I think redefining standard functionality like
this doesn't gain anything and loses some basic
grep capability.
