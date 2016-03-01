From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Feb 2016 23:14:49 -0800
Subject: [PATCH 7/8] drivers/pinctrl: make sunxi/pinctrl-sun9i-a80-r.c
 explicitly non-modular
In-Reply-To: <1456778924-20730-8-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-8-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160301071449.GL8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 03:48:43PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pinctrl/sunxi/Kconfig:config PINCTRL_SUN9I_A80_R
> drivers/pinctrl/sunxi/Kconfig:  def_bool MACH_SUN9I
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
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/26b932e5/attachment.sig>
