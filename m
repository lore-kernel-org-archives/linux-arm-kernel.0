From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 09:59:04 +0100
Subject: [PATCH 1/3] soc: sunxi: make sunxi_sram explicitly non-modular
In-Reply-To: <20161113190302.18099-2-paul.gortmaker@windriver.com>
References: <20161113190302.18099-1-paul.gortmaker@windriver.com>
 <20161113190302.18099-2-paul.gortmaker@windriver.com>
Message-ID: <20161114085904.4r7ugapbvhhlz5te@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 02:03:00PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/soc/sunxi/Kconfig:config SUNXI_SRAM
> drivers/soc/sunxi/Kconfig:      bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/be8785c8/attachment.sig>
